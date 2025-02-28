import 'dart:io';

import 'package:beurs/data/repository/app_repository.dart';
import 'package:beurs/utility/constants.dart';
import 'package:beurs/utility/interstitial_ad.dart';
import 'package:beurs/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  RxDouble rating = 3.0.obs;
  Rx<TextEditingController> feedbackController = TextEditingController().obs;
  final InterstitialAdManager adManager = InterstitialAdManager();

  @override
  void onInit() {
    checkDevice();
    super.onInit();
  }

  checkDevice() async {
    if (Platform.isAndroid) {
      adManager.loadInterstitialAd(adUnitId: Constants.reviewUnitID);
    } else {
      adManager.loadInterstitialAd(adUnitId: Constants.reviewUnitIosID);
    }
  }

  bool checkValidation() {
    if (feedbackController.value.text.trim().isEmpty) {
      Utils.showMessage("Please write your review.");
      return false;
    }
    return true;
  }

  void onReview() {
    if (checkValidation()) {
      Utils.closeKeyboard();
      Map<String, dynamic> params = {};
      params.putIfAbsent('reviewrating', () => rating.value.toString());
      params.putIfAbsent('reviewcomments',
          () => feedbackController.value.text.trim().toString());
      print("Params $params");
      AppRepository().review(params).then((value) {
        print("Params $value");
        value?.fold((l) {
          Utils.showMessage(l);
        }, (r) {
          Get.back();
          Utils.showMessage(r.statusMsg ?? "");
        });
      });
    }
  }
}
