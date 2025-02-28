import 'dart:io';

import 'package:beurs/data/repository/app_repository.dart';
import 'package:beurs/utility/constants.dart';
import 'package:beurs/utility/interstitial_ad.dart';
import 'package:beurs/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  Rx<TextEditingController> contactUsMessageController =
      TextEditingController().obs;
  final InterstitialAdManager adManager = InterstitialAdManager();

  @override
  void onInit() {
    checkDevice();
    super.onInit();
  }

  checkDevice() async {
    if (Platform.isAndroid) {
      adManager.loadInterstitialAd(adUnitId: Constants.contactUsUnitID);
    } else {
      adManager.loadInterstitialAd(adUnitId: Constants.contactUsUnitIosID);
    }
  }

  bool checkValidation() {
    if (contactUsMessageController.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter contact us message.");
      return false;
    }
    return true;
  }

  void onContactUs() {
    if (checkValidation()) {
      Utils.closeKeyboard();
      Map<String, dynamic> params = {};
      params.putIfAbsent('contactque',
          () => contactUsMessageController.value.text.trim().toString());
      AppRepository().contactUs(params).then((value) {
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
