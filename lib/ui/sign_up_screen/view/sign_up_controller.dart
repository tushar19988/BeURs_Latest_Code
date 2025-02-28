import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/utility/location_service.dart';
import 'package:beurs/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final LocationService locationService = LocationService();
  RxBool isPasswordInput = true.obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> mobileNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> reEnterPasswordController =
      TextEditingController().obs;
  RxString selectedDate = "".obs;
  RxString countryCode = "+91".obs;

  @override
  void onInit() {
    super.onInit();
    getCountryCode();
  }

  void togglePassword() {
    isPasswordInput.value = !isPasswordInput.value;
  }

  bool checkSignInValidations() {
    if (nameController.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter your name.");
      return false;
    } else if (mobileNumberController.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter your mobile number.");
      return false;
    } else if (dateController.value.text.trim().isEmpty) {
      Utils.showMessage("Please select your date of birth.");
      return false;
    } else if (emailController.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter your email address.");
      return false;
    } else if (!emailController.value.text.trim().isEmail) {
      Utils.showMessage("Please enter valid email address.");
      return false;
    } else if (passwordController.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter your password.");
      return false;
    } else if (reEnterPasswordController.value.text.trim().isEmpty) {
      Utils.showMessage("Please re-enter your password.");
      return false;
    } else if (passwordController.value.text !=
        reEnterPasswordController.value.text) {
      Utils.showMessage("Password does not match");
      return false;
    }
    return true;
  }

  Future<void> getCountryCode() async {
    countryCode.value = await locationService.getCurrentDialingCode() ?? "+91";
  }

  void onSignUp() async {
    if (checkSignInValidations()) {
      Utils.closeKeyboard();
      var deviceId = await Utils.getDeviceId();
      Map<String, dynamic> params = {};
      params.putIfAbsent('deviceid', () => deviceId.toString());
      params.putIfAbsent('username', () => nameController.value.text.trim());
      params.putIfAbsent('country_code', () => countryCode.value);
      params.putIfAbsent(
          'mobileno', () => mobileNumberController.value.text.trim());
      params.putIfAbsent('dateofbirth', () => selectedDate.value);
      params.putIfAbsent('emailid', () => emailController.value.text.trim());
      params.putIfAbsent(
          'password', () => passwordController.value.text.trim());

      UserRepository().signUp(params).then((value) {
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
