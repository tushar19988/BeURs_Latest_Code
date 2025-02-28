import 'dart:io';

import 'package:beurs/app/app_route.dart';
import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/data/network/models/get_profile_response.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/utility/location_service.dart';
import 'package:beurs/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CreateProfileController extends GetxController {
  final LocationService locationService = LocationService();
  RxBool isEditProfile = false.obs;
  Rx<TextEditingController> userName = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;
  Rx<TextEditingController> userEmail = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  GetProfileResponse profileResponse = GetProfileResponse();
  RxString userImage = "".obs;
  RxString userImageShow = "".obs;
  Rx<File> imageFile = File("").obs;
  RxString selectedDate = "".obs;
  RxString countryCode = "+91".obs;
  var argument = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    setUserData();
    getCountryCode();
    convertUriToFile();
    super.onInit();
  }

  @override
  void onReady() {
    getUserProfile();
    super.onReady();
  }

  void convertUriToFile() async {
    final http.Response responseData =
        await http.get(Uri.parse(userImageShow.value));
    Uint8List uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    imageFile.value = await File('${tempDir.path}/img').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }

  Future<void> getCountryCode() async {
    countryCode.value = await locationService.getCurrentDialingCode() ?? "+91";
  }

  void setUserData() async {
    userName.value.text = " ";
    userEmail.value.text = " ";
    dateController.value.text = " ";
    mobileNumber.value.text = " ";
    isEditProfile.value = false;
    userImageShow.value = argument["user_image"];
    print("userImageShow:- ${userImageShow.value}");
  }

  void getUserProfile() async {
    UserRepository().getUserProfile().then((value) {
      value?.fold((l) {
        Utils.showMessage(l);
      }, (r) {
        profileResponse = r;
        userName.value.text = profileResponse.username.toString();
        mobileNumber.value.text = profileResponse.mobileno!.toString();
        dateController.value.text = profileResponse.birthdate == null
            ? ""
            : "${profileResponse.birthdate!.day.toString().padLeft(2, "0")}-${profileResponse.birthdate!.month.toString().padLeft(2, "0")}-${profileResponse.birthdate!.year}";
        userEmail.value.text = profileResponse.emailid.toString();
      });
    });
  }

  bool checkSignInValidations() {
    if (userName.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter your name.");
      return false;
    } else if (mobileNumber.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter your mobile number.");
      return false;
    } else if (dateController.value.text.trim().isEmpty) {
      Utils.showMessage("Please select your date of birth.");
      return false;
    } else if (userImageShow.value.isEmpty) {
      Utils.showMessage("Please select your photo.");
      return false;
    }
    return true;
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

    print(params);
    UserRepository().updateProfile(
        params, {"profile_picture": imageFile.value}).then((value) {
      value?.fold((l) {
        Utils.showMessage(l);
      }, (r) {
        StorageManager().setAuthToken(argument["token"]);
        StorageManager().setEmail(argument["email"]);
        StorageManager().setName(argument["user_name"].toString());
        StorageManager().setUserImage(argument["user_image"].toString());
        StorageManager().setUserId(argument["user_id"].toString());
        StorageManager()
            .setUserSubscription(argument["user_subscription"] ?? false);
        Get.offAllNamed(AppRoutes.dashboardPage);
        Utils.showMessage("Profile Created Successfully.");
        isEditProfile.value = false;
        userImage.value = "";
      });
    });
  }
}
