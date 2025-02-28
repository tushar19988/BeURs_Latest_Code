import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/ui/otp_verification_screen/view/otp_verification_controller.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_app_input.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OTPVerificationScreen extends GetView<OTPVerificationController> {
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.closeKeyboard();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 295.h,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.icLoginBack),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.colorWhite,
                            size: 17.sp,
                          )),
                    ),
                    CommonTextWidget(
                      text: controller.screen == 0
                          ? "Forgot Password?"
                          : "Login With OTP",
                      textSize: 25.sp,
                      color: AppColors.colorWhite,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 34.w),
                child: Column(
                  children: [
                    CommonTextWidget(
                      text: "OTP Verification",
                      textSize: 20.sp,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    CommonAppInput(
                      height: 60.h,
                      isOtp: true,
                      hintText: "Please Enter OTP",
                      textEditingController: controller.otpController.value,
                      textInputType: TextInputType.number,
                      contentPaddingVertical: 20.h,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CommonAppButton(
                      text: "Verify",
                      onClick: () {
                        controller.onOtpVerification();
                        //Get.toNamed(AppRoutes.resetPasswordPage);
                      },
                      height: 60.h,
                      borderRadius: 10.r,
                      appColor: AppColors.color8A29C4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
