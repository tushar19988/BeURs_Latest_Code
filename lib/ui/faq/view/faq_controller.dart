import 'dart:io';

import 'package:beurs/data/network/models/privacy_policy_model.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/utility/constants.dart';
import 'package:beurs/utility/interstitial_ad.dart';
import 'package:beurs/utility/utils.dart';
import 'package:get/get.dart';

class FaqController extends GetxController {
  RxList<PrivacyResponse> faqList = <PrivacyResponse>[].obs;
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
      adManager.loadInterstitialAd(adUnitId: Constants.faqUnitID);
    } else {
      adManager.loadInterstitialAd(adUnitId: Constants.faqUnitIosID);
    }
  }

  Future<void> getFaqApi() async {
    UserRepository().getFaq().then(
      (value) {
        value?.fold(
          (l) {
            isLoading.value = false;
            Utils.showMessage(l);
          },
          (r) {
            faqList.value = r;
            isLoading.value = false;
          },
        );
      },
    );
  }
}
