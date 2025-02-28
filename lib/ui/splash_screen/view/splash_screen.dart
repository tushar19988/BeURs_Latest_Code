import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/app/app_route.dart';
import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/ui/splash_screen/view/splash_controller.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_app_image.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.icSplashBackground),
                fit: BoxFit.fitWidth)),
        child: Stack(
          children: [
            SizedBox(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonAppImage(
                    imagePath: AppImages.icSplashAppIcon,
                    height: 219.h,
                    fit: BoxFit.contain,
                    width: 219.w,
                  ),
                  SizedBox(
                    height: 26.h,
                  ),


                  Text("Welcome!",style: TextStyle(fontFamily: "frisky",fontSize: 40.sp,color: AppColors.colorWhite
                  ),),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: CommonTextWidget(
                      text:
                          "At Beurs.in, we specialize in infusing joy and creating unforgettable moments that linger in the hearts of millions.",
                      textSize: 18.sp,
                      textAlign: TextAlign.center,
                      color: AppColors.colorWhite,
                    ),
                  )
                ],
              ),
            ),
            /*Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40.h),
                child: CommonAppButton(
                  text: "Get Started",
                  onClick: () {
                    StorageManager().setFromFresh(false);
                    controller.onGetStartedClick();
                  },
                  width: 254.w,
                  borderRadius: 10.r,
                  height: 62.h,
                  appColor: AppColors.colorWhite,
                  textColor: AppColors.color8A29C4,
                  fontWeight: AppFontWeight.medium,
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
