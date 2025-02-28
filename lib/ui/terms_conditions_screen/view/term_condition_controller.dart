import 'dart:io';

import 'package:beurs/data/network/models/about_us_reponse.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/utility/constants.dart';
import 'package:beurs/utility/interstitial_ad.dart';
import 'package:beurs/utility/utils.dart';
import 'package:get/get.dart';

class TermConditionController extends GetxController {
  RxList<AboutUsResponse> termConditionList = <AboutUsResponse>[].obs;
  AboutUsResponse aboutUsResponse = AboutUsResponse();

  RxBool isLoading = true.obs;
  final InterstitialAdManager adManager = InterstitialAdManager();
  @override
  void onInit() {
    getTermsConditionApi();
    checkDevice();
    super.onInit();
  }

  checkDevice() async {
    if (Platform.isAndroid) {
      adManager.loadInterstitialAd(adUnitId: Constants.termsConditionUnitID);
    } else {
      adManager.loadInterstitialAd(adUnitId: Constants.termsConditionUnitIosID);
    }
  }

  Future<void> getTermsConditionApi() async {
    UserRepository().getTermsConditions().then(
      (value) {
        value?.fold(
          (l) {
            isLoading.value = false;
            Utils.showMessage(l);
          },
          (r) {
            termConditionList.value = r;
            aboutUsResponse = termConditionList.first;
            isLoading.value = false;
          },
        );
      },
    );
  }
}
