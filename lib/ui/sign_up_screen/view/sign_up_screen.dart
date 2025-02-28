import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/app/app_route.dart';
import 'package:beurs/ui/sign_up_screen/view/sign_up_controller.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_app_input.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

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
                  height: 295.h,
                  width: Get.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.icLoginBack),
                          fit: BoxFit.fitWidth)),
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
                      /* CommonTextWidget(text: "Hello!",
                    textSize: 25.sp,
                    color: AppColors.colorWhite,), SizedBox(height: 3.h,),
                  CommonTextWidget(text: "Sign up to get started!",
                    textSize: 25.sp,
                    color: AppColors.colorWhite,),*/
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
                        text: "Create Your Account",
                        textSize: 20.sp,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      CommonAppInput(
                        height: 60.h,
                        hintText: "Enter Your Name",
                        textEditingController: controller.nameController.value,
                        contentPaddingVertical: 16.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CommonAppInput(
                        height: 60.h,
                        hintText: "Enter Your Mobile Number",
                        textEditingController:
                            controller.mobileNumberController.value,
                        prefixIcon: Padding(
                          padding: REdgeInsets.only(
                            left: 24.w,
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
                        contentPaddingVertical: 16.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Utils.selectDate(context, DateTime.now())
                              .then((value) {
                            if (value != null) {
                              var userSelectedDate =
                                  DateTime(value.year, value.month, value.day);

                              //the duration difference form the selected date to now in days
                              var days = DateTime.now()
                                  .difference(userSelectedDate)
                                  .inDays;

                              //the duration difference in years (the current age)
                              var age = days / 365;

                              if (age > 7) {
                                controller.dateController.value.text =
                                    "${value.day.toString().padLeft(2, "0")}/${value.month.toString().padLeft(2, "0")}/${value.year}";
                                controller.selectedDate.value =
                                    "${value.year.toString()}-${value.month.toString().padLeft(2, "0")}-${value.day.toString().padLeft(2, "0")}";
                              } else {
                                Utils.showMessage(
                                    "Your age should be above 7.");
                              }
                            }
                          });
                        },
                        child: CommonAppInput(
                          height: 60.h,
                          isEnable: false,
                          hintText: "Enter Your Date of Birth",
                          textEditingController:
                              controller.dateController.value,
                          contentPaddingVertical: 16.h,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CommonAppInput(
                        height: 60.h,
                        hintText: "Enter Your e-mail ID",
                        textInputType: TextInputType.emailAddress,
                        textEditingController: controller.emailController.value,
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
                        height: 10.h,
                      ),
                      CommonAppInput(
                        height: 60.h,
                        hintText: "Re-Enter Password",
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
                            controller.reEnterPasswordController.value,
                        contentPaddingVertical: 16.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CommonAppButton(
                        text: "Sign Up",
                        onClick: () {
                          controller.onSignUp();
                        },
                        height: 60.h,
                        borderRadius: 10.r,
                        appColor: AppColors.color8A29C4,
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonTextWidget(
                            text: "Already have an account?",
                            textSize: 14.sp,
                            fontWeight: AppFontWeight.light,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(AppRoutes.loginPage);
                            },
                            child: CommonTextWidget(
                              text: "Sign In here.",
                              textSize: 14.sp,
                              fontWeight: AppFontWeight.semiBold,
                              color: AppColors.color8A29C4,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
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
