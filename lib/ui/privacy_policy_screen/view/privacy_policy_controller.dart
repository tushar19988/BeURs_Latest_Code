import 'dart:io';

import 'package:beurs/data/network/models/about_us_reponse.dart';
import 'package:beurs/data/network/models/privacy_policy_model.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/utility/constants.dart';
import 'package:beurs/utility/interstitial_ad.dart';
import 'package:beurs/utility/utils.dart';
import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  RxList<AboutUsResponse> privacyList = <AboutUsResponse>[].obs;
  AboutUsResponse aboutUsResponse = AboutUsResponse();

  RxBool isLoading = true.obs;
  final InterstitialAdManager adManager = InterstitialAdManager();

  @override
  void onInit() {
    getPrivacyApi();
    checkDevice();
    super.onInit();
  }

  checkDevice() async {
    if (Platform.isAndroid) {
      adManager.loadInterstitialAd(adUnitId: Constants.policyUnitID);
    } else {
      adManager.loadInterstitialAd(adUnitId: Constants.policyUnitIosID);
    }
  }

  Future<void> getPrivacyApi() async {
    UserRepository().getPrivacyPolicy().then(
      (value) {
        value?.fold(
          (l) {
            isLoading.value = false;
            Utils.showMessage(l);
          },
          (r) {
            privacyList.value = r;
            aboutUsResponse = privacyList.first;
            isLoading.value = false;
          },
        );
      },
    );
  }
}
