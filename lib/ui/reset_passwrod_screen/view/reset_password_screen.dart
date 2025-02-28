import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/ui/reset_passwrod_screen/view/reset_password_controller.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_app_input.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.closeKeyboard();
      },
      child: Obx(() {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 324.h,
                  width: Get.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.icLoginBack),
                          fit: BoxFit.fill)),
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
                        text: "Reset",
                        textSize: 25.sp,
                        color: AppColors.colorWhite,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CommonTextWidget(
                        text: "Password",
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
                      CommonTextWidget(
                        text: "Reset Password",
                        textSize: 20.sp,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      CommonAppInput(
                        height: 60.h,
                        hintText: "Please Enter New Password",
                        isPassword:
                            !controller.isPasswordInput.value ? false : true,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.togglePassword();
                          },
                          child: Icon(
                            !controller.isPasswordInput.value
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: AppColors.color9C9C9C,
                          ),
                        ),
                        textEditingController:
                            controller.passwordController.value,
                        contentPaddingVertical: 16.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CommonAppInput(
                        height: 60.h,
                        hintText: "Re-enter New Password",
                        isPassword:
                            !controller.isRePasswordInput.value ? false : true,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.toggleRePassword();
                          },
                          child: Icon(
                            !controller.isRePasswordInput.value
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: AppColors.color9C9C9C,
                          ),
                        ),
                        textEditingController:
                            controller.reEnterPasswordController.value,
                        contentPaddingVertical: 16.h,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CommonAppButton(
                        text: "Confirm",
                        onClick: () {
                          controller.onResetPassword();
                          //Get.offAllNamed(AppRoutes.loginPage);
                        },
                        height: 60.h,
                        borderRadius: 10.r,
                        appColor: AppColors.color8A29C4,
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
