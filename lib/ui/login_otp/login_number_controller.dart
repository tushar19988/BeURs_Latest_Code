import 'package:beurs/app/app_route.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginNumberController());
  }
}

class LoginNumberController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  RxString countryCode = "+91".obs;

  void sendNumberOtp() {
    //
    if (phoneController.text.isNotEmpty) {
      Utils.closeKeyboard();
      Map<String, dynamic> params = {};
      params.putIfAbsent(
        'mobileno',
        () => phoneController.text.trim(),
      );
      params.putIfAbsent(
        'country_code',
        () => countryCode.value,
      );

      UserRepository().sendOtp(params).then((value) {
        value?.fold((l) {
          Utils.showMessage(l);
        }, (r) {
          Get.toNamed(AppRoutes.otpVerificationPage, arguments: {
            "countryCode": countryCode.value,
            "mobileno": phoneController.text.toString(),
            "screen": 1,
          });
        });
      });
    }
  }
}
