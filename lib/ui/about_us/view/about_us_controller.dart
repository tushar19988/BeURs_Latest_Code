import 'dart:io';

import 'package:beurs/data/network/models/about_us_reponse.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/utility/constants.dart';
import 'package:beurs/utility/interstitial_ad.dart';
import 'package:beurs/utility/utils.dart';
import 'package:get/get.dart';

class AboutUsController extends GetxController {
  RxList<AboutUsResponse> aboutUsList = <AboutUsResponse>[].obs;
  AboutUsResponse aboutUsResponse = AboutUsResponse();
  RxBool isLoading = true.obs;
  final InterstitialAdManager adManager = InterstitialAdManager();

  @override
  void onInit() {
    getFaqApi();
    checkDevice();
    super.onInit();
  }

  checkDevice() async {
    if (Platform.isAndroid) {
      adManager.loadInterstitialAd(adUnitId: Constants.aboutUnitID);
    } else {
      adManager.loadInterstitialAd(adUnitId: Constants.aboutUnitIosID);
    }
  }

  Future<void> getFaqApi() async {
    UserRepository().getAbout().then(
      (value) {
        value?.fold(
          (l) {
            isLoading.value = false;
            Utils.showMessage(l);
          },
          (r) {
            aboutUsList.value = r;
            aboutUsResponse = aboutUsList.first;
            isLoading.value = false;
          },
        );
      },
    );
  }
}
