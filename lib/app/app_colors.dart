import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/ui/splash_screen/view/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class AppColors extends GetxController {
  static AppColors get to => Get.find();

  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    isDarkMode.value = StorageManager().getThemeType() ?? false;
    Get.put(SplashController());

    super.onInit();
  }

  Color get primaryColor => isDarkMode.value ? _darkPrimaryColor : _lightPrimaryColor;

  Color get bgColor => isDarkMode.value ? _darkBgColor : _lightBgColor;

  Color get textColor => isDarkMode.value ? _darkTextColor : _lightTextColor;

  Color get buttonTextColor => isDarkMode.value ? _darkBtnTextColor : _lightBtnTextColor;

  // Light mode colors
  static const Color _lightPrimaryColor = Color(0xFF495AA8);
  static const Color _lightTextColor = Color(0xFF717179);
  static const Color _lightBgColor = Color(0xFFFFFFFF);
  static const Color _lightBtnTextColor = Color(0xFFFFFFFF);

  // Dark mode colors
  static const Color _darkPrimaryColor = Color(0xFF546032);
  static const Color _darkTextColor = Color(0xFF09331D);
  static const Color _darkBgColor = Color(0xFFFFFFFF);
  static const Color _darkBtnTextColor = Color(0xFFFFFFFF);

  //static const Color _darkBtnTextColor = Color(0xFF001331);

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    StorageManager().setThemeType(isDarkMode.value);
  }

  static const Color colorIndicatorDot = Color(0xFF546032);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorBlack = Color(0xFF000000);
  static const Color color4E4E4E= Color(0xFF4E4E4E);
  static const Color colorAE9AC5 = Color(0xFFAE9AC5);
  static const Color color65646C = Color(0xFF65646C);
  static const Color colorDFD2F3 = Color(0xFFDFD2F3);
  static const Color colorF8F8F8 = Color(0xFFF8F8F8);
  static const Color color151515 = Color(0xFF151515);
  static const Color colorA0A0A0 = Color(0xFFA0A0A0);
  static const Color color73C37D = Color(0xFF73C37D);
  static const Color colorF7F7F7 = Color(0xFFF7F7F7);
  static const Color color717179 = Color(0xFF717179);
  static const Color colorC6B4B4 = Color(0xFFC6B4B4);
  static const Color color0063FF = Color(0xFF0063FF);
  static const Color colorC5CCD7 = Color(0xFFC5CCD7);
  static const Color color040404 = Color(0xFF040404);
  static const Color colorF8D7D7 = Color(0xffF8D7D7);
  static const Color colorShadow = Color(0x00000029);
  static const Color colorA4A5AA = Color(0xFFA4A5AA);
  static const Color colorEBEBF5 = Color(0xFFEBEBF5);
  static const Color color01B3A3 = Color(0xFF01B3A3);
  static const Color colorE8E8E8 = Color(0xFFE8E8E8);
  static const Color color013567 = Color(0xFF013567);
  static const Color colorF44545 = Color(0xFFF44545);
  static const Color colorFD9904 = Color(0xFFFD9904);
  static const Color color626262 = Color(0xFF626262);
  static const Color color1A1A1A = Color(0xFF1A1A1A);
  static const Color color393939 = Color(0xFF393939);
  static const Color colorECECEC = Color(0xFFECECEC);
  static const Color color8B9AAC = Color(0xFF8B9AAC);



  static const Color color939393 = Color(0xFF939393);

    //////////////////////////////   BeUrs ----------------

  static const Color color8A29C4 = Color(0xFF8A29C4);
  static const Color colorEFEFEF = Color(0xFFEFEFEF);
  static const Color color9C9C9C = Color(0xFF9C9C9C);
  static const Color colorD9D9D9 = Color(0xFFD9D9D9);
  static const Color color505050 = Color(0xFF505050);
  static const Color colorE9E9E9 = Color(0xFFE9E9E9);
  static const Color colorFF8F0E = Color(0xFFFF8F0E);
  static const Color colorCCCCCC = Color(0xFFCCCCCC);
  static const Color color9F45D4 = Color(0xFF9F45D4);
  static const Color colorF1D9FF = Color(0xFFF1D9FF);
  static const Color colorF3F3F3 = Color(0xFFF3F3F3);
  static const Color color8125B8 = Color(0xFF8125B8);


}
