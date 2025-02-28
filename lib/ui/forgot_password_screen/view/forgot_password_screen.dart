import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/ui/forgot_password_screen/view/forgot_password_controller.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_app_input.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        ),
                      ),
                    ),
                    CommonTextWidget(
                      text: "Forgot Password?",
                      textSize: 25.sp,
                      color: AppColors.colorWhite,
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
                    SizedBox(
                      height: 25.h,
                    ),
                    CommonAppInput(
                      height: 60.h,
                      hintText: "Enter Your Mobile Number",
                      textEditingController:
                          controller.mobileNumberController.value,
                      contentPaddingVertical: 16.h,
                      prefixIcon: Padding(
                        padding: REdgeInsets.only(
                          left: 15.w,
                          right: 4.w,
                          top: 1.h,
                        ),
                        child: CommonTextWidget(
                          text: controller.countryCode.value,
                          style: GoogleFonts.montserrat(
                            color: AppColors.color013567,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      isMobileNumber: true,
                      textInputType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CommonAppButton(
                      text: "Request New Password",
                      onClick: () {
                        //Get.toNamed(AppRoutes.otpVerificationPage);
                        controller.onForgotPassword();
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
