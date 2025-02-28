import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/app/app_route.dart';
import 'package:beurs/ui/login_screen/view/login_controller.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_app_image.dart';
import 'package:beurs/widgets/common_app_input.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

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
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70.h,
                      ),
                      CommonTextWidget(
                        text: "Hello!",
                        textSize: 25.sp,
                        color: AppColors.colorWhite,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CommonTextWidget(
                        text: "Welcome back!",
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
                        text: "Login To Your Account",
                        textSize: 20.sp,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      CommonAppInput(
                        height: 60.h,
                        hintText: "Enter Your e-mail ID",
                        textEditingController: controller.emailController.value,
                        textInputType: TextInputType.emailAddress,
                        contentPaddingVertical: 16.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CommonAppInput(
                        height: 60.h,
                        hintText: "Enter Your Password",
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
                        height: 12.h,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.forgotPasswordPage);
                          },
                          child: CommonTextWidget(
                            text: "Forgot Password ?",
                            textSize: 13.sp,
                            color: AppColors.color8A29C4,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CommonAppButton(
                        text: "Sign In",
                        onClick: () {
                          //Get.toNamed(AppRoutes.dashboardPage);
                          controller.onSignIn();
                        },
                        height: 60.h,
                        borderRadius: 10.r,
                        appColor: AppColors.color8A29C4,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CommonAppButton(
                        text: "Login With Number",
                        onClick: () {
                          Get.toNamed(AppRoutes.loginNumber);
                        },
                        height: 60.h,
                        borderRadius: 10.r,
                        appColor: AppColors.color8A29C4,
                      ),

                        SizedBox(
                          height: 17.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 1.h,
                              color: AppColors.colorD9D9D9,
                            )),
                            SizedBox(
                              width: 10.w,
                            ),
                            CommonTextWidget(
                              text: "Or",
                              textSize: 12.sp,
                              color: AppColors.color9C9C9C,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                child: Container(
                              height: 1.h,
                              color: AppColors.colorD9D9D9,
                            )),
                          ],
                        ),

                        /// Login With Facebook Code

                      
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        //
                        // GestureDetector(
                        //   onTap: () {
                        //     controller.signInWithFacebook();
                        //   },
                        //   child: Container(
                        //     height: 60.h,
                        //     width: Get.width,
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10.r),
                        //         color: AppColors.colorWhite,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey.withOpacity(0.2),
                        //             blurRadius: 8.0,
                        //           ),
                        //         ]),
                        //     child: Row(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         CommonAppImage(
                        //           imagePath: AppImages.icFacebookIcon,
                        //           height: 28.h,
                        //           width: 28.w,
                        //         ),
                        //         SizedBox(
                        //           width: 8.w,
                        //         ),
                        //         CommonTextWidget(
                        //             text: "Sign In With Facebook",
                        //             textSize: 18.sp)
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CommonTextWidget(
                        text: "Don’t have an Account?",
                        textSize: 14.sp,
                        fontWeight: AppFontWeight.light,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.signUpPage);
                        },
                        child: CommonTextWidget(
                          text: "Sign Up here.",
                          textSize: 14.sp,
                          fontWeight: AppFontWeight.semiBold,
                          color: AppColors.color8A29C4,
                        ),
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
