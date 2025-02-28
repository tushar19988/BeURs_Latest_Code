import 'package:beurs/app/app_colors.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_app_input.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/app_images.dart';
import 'login_number_controller.dart';

class PhoneNumberScreen extends GetView<LoginNumberController> {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Column(
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
                    text: "Enter Number",
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
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 34.w),
              child: Column(
                children: [
                  CommonAppInput(
                    height: 60.h,
                    // isEnable: true,
                    contentPaddingVertical: 16.h,
                    hintText: "Enter Your Mobile Number",
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
                    textEditingController: controller.phoneController,
                    isMobileNumber: true,
                    textInputType: TextInputType.phone,
                    //  contentPaddingVertical: 16.h,
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  CommonAppButton(
                    text: "Next",
                    onClick: () {
                      controller.sendNumberOtp();
                      // Get.toNamed(AppRoutes.otpVerificationPage);
                    },
                    height: 60.h,
                    borderRadius: 10.r,
                    appColor: AppColors.color8A29C4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
