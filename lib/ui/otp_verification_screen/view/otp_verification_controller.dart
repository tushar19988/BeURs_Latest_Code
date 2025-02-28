import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:beurs/app/app_route.dart';
import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/data/network/models/login_response.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/utility/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPVerificationController extends GetxController {
  Rx<TextEditingController> otpController = TextEditingController().obs;

  String? email = StorageManager().getEmail().toString();
  final Map<String, dynamic> arguments = Get.arguments ?? {};
  LoginResponse loginResponse = LoginResponse();
  RxString getFCMToken = "".obs;

  String mobileNo = '';
  String countryCode = '';

  // 0 => forgotpass Screen
  // 1 => login with number verrification
  int screen = 0;

  bool checkSignInValidations() {
    if (otpController.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter OTP");
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  getArgument() async {
    screen = arguments['screen'];
    mobileNo = arguments["mobileno"];
    countryCode = arguments["countryCode"];
    update();
    await getFirebaseToken();
  }

  getFirebaseToken() {
    if (Platform.isAndroid) {
      FirebaseMessaging.instance.getToken().then((getTokenValue) {
        debugPrint("=======FCM:- $getTokenValue");
        getFCMToken.value = getTokenValue ?? "aa";
      });
    } else {
      FirebaseMessaging.instance.getAPNSToken().then((getAPNTokenValue) {
        debugPrint("=======FCM:- $getAPNTokenValue");
        getFCMToken.value = getAPNTokenValue ?? "aa";
      });
    }
  }

  void onOtpVerification() async {
    if (screen == 0) {
      if (checkSignInValidations()) {
        Utils.closeKeyboard();
        Map<String, dynamic> params = {};
        params.putIfAbsent('country_code', () => countryCode);
        params.putIfAbsent('mobileno', () => mobileNo);
        params.putIfAbsent('otp', () => otpController.value.text.trim());
        UserRepository().otpVerification(params).then((value) {
          value?.fold((l) {
            Utils.showMessage(l);
          }, (r) {
            Get.toNamed(AppRoutes.resetPasswordPage, arguments: {
              "countryCode": arguments["countryCode"],
              "mobileno": arguments["mobileno"],
            });
            otpController.value.clear();
          });
        });
      }
    } else {
      if (checkSignInValidations()) {
        Utils.closeKeyboard();
        var deviceId = await Utils.getDeviceId();
        debugPrint("Device Id $deviceId");

        // Map<String, dynamic> params = {};
        // params.putIfAbsent('country_code', () => arguments["countryCode"]);

        Map<String, dynamic> params = {
          "mobileno": mobileNo.trim(),
          "otp": otpController.value.text.trim(),
          "devicename": Platform.isAndroid ? "android" : "ios",
          "devicetype": Platform.isAndroid ? "android" : "ios",
          "deviceid": deviceId.trim(),
          "devicetoken": (getFCMToken.value ?? "").toString(),
        };

        // Map<String, dynamic> params = {};
        // params.putIfAbsent('mobileno', () => mobileNo.trim());
        // params.putIfAbsent('otp', () => otpController.value.text.trim());
        // // params.putIfAbsent('country_code', () => countryCode.value);
        // params.putIfAbsent(
        //     'devicename', () => Platform.isAndroid ? "android" : "ios");
        // params.putIfAbsent(
        //     'devicetype', () => Platform.isAndroid ? "android" : "ios");
        // params.putIfAbsent('deviceid', () => deviceId.trim());
        // params.putIfAbsent('devicetoken', () => getFCMToken.value ?? "");

        print("Payload: $params");

        UserRepository().numberOtpVerification(params).then((value) {
          value?.fold((l) {
            Utils.showMessage(l);
          }, (r) {
            loginResponse = r.data;

            StorageManager().setAuthToken(loginResponse.accessToken.toString());
            log("Token Value ${loginResponse.accessToken.toString()}");
            StorageManager().setEmail(loginResponse.emailid.toString());
            StorageManager().setName(loginResponse.username.toString());
            StorageManager().setUserImage(loginResponse.userimage.toString());
            StorageManager().setUserId(loginResponse.userid.toString());
            StorageManager()
                .setUserSubscription(loginResponse.isSubscription ?? false);

            otpController.value.clear();

            Get.offAllNamed(AppRoutes.dashboardPage);
          });
        });
      }
    }
  }
}
