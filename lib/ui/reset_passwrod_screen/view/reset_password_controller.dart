import 'package:beurs/app/app_route.dart';
import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  RxBool isPasswordInput = true.obs;
  RxBool isRePasswordInput = true.obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> reEnterPasswordController = TextEditingController().obs;
  String? userId = StorageManager().getUserId();
  String? email = StorageManager().getEmail();
  var argument = Get.arguments;

  void togglePassword() {
    isPasswordInput.value = !isPasswordInput.value;
  }

  void toggleRePassword() {
    isRePasswordInput.value = !isRePasswordInput.value;
  }

  bool checkSignInValidations() {
    if (passwordController.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter your new password.");
      return false;
    } else if (reEnterPasswordController.value.text.trim().isEmpty) {
      Utils.showMessage("Please re-enter your password.");
      return false;
    } else if (passwordController.value.text != reEnterPasswordController.value.text) {
      Utils.showMessage("Password does not match.");
      return false;
    }
    return true;
  }

  void onResetPassword() async {
    if (checkSignInValidations()) {
      Utils.closeKeyboard();
      Map<String, dynamic> params = {};
      params.putIfAbsent('country_code', () => argument["countryCode"]);
      params.putIfAbsent('mobileno', () => argument["mobileno"]);
      params.putIfAbsent('userpassword', () => passwordController.value.text.trim());
      UserRepository().changePassword(params).then((value) {
        value?.fold((l) {
          Utils.showMessage(l);
        }, (r) {
          Get.offAllNamed(AppRoutes.loginPage);
        });
      });
    }
  }
}
