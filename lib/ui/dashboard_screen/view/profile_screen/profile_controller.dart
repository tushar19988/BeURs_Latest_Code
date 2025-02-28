import 'dart:developer';
import 'dart:io';

import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/data/network/models/get_profile_response.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/ui/dashboard_screen/view/dashboard_controller.dart';
import 'package:beurs/ui/dashboard_screen/view/home_screen/home_controller.dart';
import 'package:beurs/utility/constants.dart';
import 'package:beurs/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ProfileController extends GetxController {
  DashboardController dashboardController = Get.find<DashboardController>();
  HomeController homeController = Get.find<HomeController>();
  RxBool isEditProfile = false.obs;
  Rx<TextEditingController> userName = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;
  Rx<TextEditingController> userEmail = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  GetProfileResponse profileResponse = GetProfileResponse();
  RxBool isLoading = true.obs;
  RxString userImage = "".obs;
  RxString userImageShow = "".obs;
  Rx<File> imageFile = File('').obs;
  RxString selectedDate = "".obs;
  RxString countryCode = "+91".obs;
  static RxBool isAdLoaded = false.obs;

  /// Short Banner
  late final BannerAd bannerAd;
  final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (Ad ad) {
      isAdLoaded.value = true; // Set this to true when the ad is loaded
      debugPrint("Ad Loaded");
    },
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      isAdLoaded.value = false; // Set this to false if the ad fails to load
      debugPrint("Ad failed Load");
    },
    onAdOpened: (ad) => debugPrint("Ad Open"),
  );

  @override
  void onInit() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isAndroid
          ? Constants.profileBannerID
          : Constants.profileBannerIosID,
      listener: bannerAdListener,
      request: const AdRequest(),
    );
    bannerAd.load(); // Load the ad after initialization
    setUserData();
    convertUriToFile();
    super.onInit();
  }

  @override
  void onReady() {
    getUserProfile();
    super.onReady();
  }

  void setUserData() {
    userName.value.text = " ";
    userEmail.value.text = " ";
    dateController.value.text = " ";
    mobileNumber.value.text = " ";
    isEditProfile.value = false;
  }

  void convertUriToFile() async {
    try {
      // Ensure the URL is valid
      final String imageUrl = userImageShow.value;
      if (imageUrl.isEmpty || !Uri.parse(imageUrl).isAbsolute) {
        throw Exception("Invalid URL: $imageUrl");
      }

      // Fetch image data
      final http.Response responseData = await http.get(Uri.parse(imageUrl));
      if (responseData.statusCode == 200) {
        Uint8List uint8list = responseData.bodyBytes;
        var buffer = uint8list.buffer;

        // Get temporary directory
        var tempDir = await getTemporaryDirectory();
        var tempFilePath = '${tempDir.path}/img';

        // Write data to file
        imageFile.value =
            await File(tempFilePath).writeAsBytes(buffer.asUint8List());

        log("Image saved to: $tempFilePath");
      } else {
        throw Exception(
            "Failed to download image, status code: ${responseData.statusCode}");
      }
    } catch (e) {
      log("Error in convertUriToFile: $e");
    }
  }

  void getUserProfile() async {
    UserRepository().getUserProfile().then((value) {
      value?.fold((l) {
        // Utils.showMessage(l);
        isLoading.value = false;
      }, (r) {
        isLoading.value = false;
        profileResponse = r;
        userName.value.text = profileResponse.username.toString();
        mobileNumber.value.text = profileResponse.mobileno!.toString();
        dateController.value.text = profileResponse.birthdate == null
            ? ""
            : "${profileResponse.birthdate!.day.toString().padLeft(2, "0")}-${profileResponse.birthdate!.month.toString().padLeft(2, "0")}-${profileResponse.birthdate!.year}";
        userEmail.value.text = profileResponse.emailid.toString();
        userImageShow.value = profileResponse.userimage.toString();
        StorageManager().setEmail(profileResponse.emailid.toString());
        StorageManager().setName(profileResponse.username.toString());
        StorageManager().setUserImage(profileResponse.userimage.toString());
        StorageManager().setUserId(profileResponse.id.toString());
        homeController.profile.value = profileResponse.userimage.toString();
        homeController.userName.value = profileResponse.username.toString();
        countryCode.value = profileResponse.countryCode.toString();
        print("Country Code${profileResponse.countryCode.toString()}");
      });
    });
  }

  void updateProfile() async {
    Utils.closeKeyboard();
    Map<String, String> params = {};
    params.putIfAbsent('username', () => userName.value.text.trim().toString());
    params.putIfAbsent('country_code', () => countryCode.value);
    params.putIfAbsent(
        'mobileno', () => mobileNumber.value.text.trim().toString());
    params.putIfAbsent(
      'birthdate',
      () => selectedDate.value != ""
          ? selectedDate.value
          : "${profileResponse.birthdate!.year.toString()}-${profileResponse.birthdate!.month.toString().padLeft(2, "0")}-${profileResponse.birthdate!.day.toString().padLeft(2, "0")}",
    );
    UserRepository().updateProfile(
        params, {"profile_picture": imageFile.value}).then((value) {
      value?.fold((l) {
        Utils.showMessage(l);
      }, (r) {
        Utils.showMessage(r ?? "");
        isEditProfile.value = false;
        userImage.value = "";
        getUserProfile();
      });
    });
  }
}
