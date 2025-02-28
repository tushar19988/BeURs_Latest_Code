import 'package:beurs/app/app_route.dart';
import 'package:beurs/data/local/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class WalkthroughController extends GetxController{
  RxInt slideIndex = 0.obs;
  PageController? pageController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    removeSplash();
    pageController =  PageController();
    pageController!.addListener(() {});
  }
  void removeSplash() async {
    Future.delayed(const Duration(seconds: 5), () {
      FlutterNativeSplash.remove();
    });
  }
  void goToNextPage(int page) {
    pageController!.animateToPage(page,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void goToSkipGetStarted(){
    StorageManager().setFromFresh(false);
    String? isToken = StorageManager().getAuthToken();
    if(isToken == null){
      Get.offAndToNamed(AppRoutes.loginPage);
    }else{
      Get.offAndToNamed(AppRoutes.dashboardPage);
    }

  }
}