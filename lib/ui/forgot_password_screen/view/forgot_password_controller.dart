import 'package:beurs/app/app_route.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/utility/location_service.dart';
import 'package:beurs/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final LocationService locationService = LocationService();
  Rx<TextEditingController> mobileNumberController =
      TextEditingController().obs;
  RxString countryCode = "+91".obs;

  @override
  void onInit() {
    super.onInit();
    getCountryCode();
  }

  @override
  void onReady() {
    getCountryCode();
    super.onReady();
  }

  bool checkSignInValidations() {
    if (mobileNumberController.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter your mobile number.");
      return false;
    }
    return true;
  }

  Future<void> getCountryCode() async {
    countryCode.value = await locationService.getCurrentDialingCode() ?? "+91";
  }

  void onForgotPassword() async {
    if (checkSignInValidations()) {
      Utils.closeKeyboard();
      Map<String, dynamic> params = {};
      params.putIfAbsent('country_code', () => countryCode.value);
      params.putIfAbsent(
          'mobileno', () => mobileNumberController.value.text.trim());
      UserRepository().forgotPassword(params).then((value) {
        value?.fold((l) {
          Utils.showMessage(l);
        }, (r) {
          Get.toNamed(AppRoutes.otpVerificationPage, arguments: {
            "countryCode": countryCode.value,
            "mobileno": mobileNumberController.value.text.toString(),
            "screen": 0,
          });
          mobileNumberController.value.clear();
        });
      });
    }
  }
}
