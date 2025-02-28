import 'dart:convert';
import 'dart:io' as io;
import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/app/app_route.dart';
import 'package:beurs/ui/dashboard_screen/view/profile_screen/profile_controller.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_ad_banner.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_app_image.dart';
import 'package:beurs/widgets/common_app_input.dart';
import 'package:beurs/widgets/common_cached_images.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.closeKeyboard();
      },
      child: Obx(() {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      // Header Section
                      Container(
                        height: 210.h,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.icDashboardBackImage),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 46.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(height: 70.h),
                                  SizedBox(width: 70.w),
                                  Expanded(
                                    child: Center(
                                      child: CommonTextWidget(
                                        text: "Profile",
                                        textSize: 20.sp,
                                        fontWeight: AppFontWeight.semiBold,
                                        color: AppColors.colorWhite,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.notificationPage);
                                    },
                                    child: SizedBox(
                                      height: 33.h,
                                      width: 26.w,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: CommonAppImage(
                                              imagePath:
                                                  AppImages.icNotificationIcon,
                                              height: 22.h,
                                              width: 21.w,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.dashboardController
                                            .openSideDrawer(true);
                                      },
                                      child: CommonAppImage(
                                        imagePath: AppImages.icMenuIcon,
                                        height: 13.h,
                                        width: 21.w,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Profile Content
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: REdgeInsets.only(top: 38.h),
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: AppColors.colorWhite,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 8.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: REdgeInsets.only(
                                    left: 18.w,
                                    right: 18.w,
                                    top: 70.h,
                                    bottom: 24.h,
                                  ),
                                  child: Column(
                                    children: [
                                      CommonAppInput(
                                        height: 60.h,
                                        isEnable:
                                            controller.isEditProfile.isTrue,
                                        hintText: "Enter Your User Name",
                                        textEditingController:
                                            controller.userName.value,
                                        contentPaddingVertical: 16.h,
                                      ),
                                      SizedBox(height: 16.h),
                                      CommonAppInput(
                                        height: 60.h,
                                        isEnable:
                                            controller.isEditProfile.isTrue,
                                        hintText: "Enter Your Mobile Number",
                                        contentPaddingVertical: 16.h,
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
                                        textEditingController:
                                            controller.mobileNumber.value,
                                        // contentPaddingVertical: 8.h,
                                      ),
                                      SizedBox(height: 16.h),
                                      CommonAppInput(
                                        height: 60.h,
                                        isEnable:
                                            !controller.isEditProfile.isTrue,
                                        hintText: "Enter Your Email",
                                        textEditingController:
                                            controller.userEmail.value,
                                        contentPaddingVertical: 16.h,
                                      ),
                                      SizedBox(height: 16.h),
                                      GestureDetector(
                                        onTap: () {
                                          if (controller.isEditProfile.value) {
                                            Utils.selectDate(
                                                    context, DateTime.now())
                                                .then((value) {
                                              if (value != null) {
                                                var userSelectedDate = DateTime(
                                                  value.year,
                                                  value.month,
                                                  value.day,
                                                );

                                                var days = DateTime.now()
                                                    .difference(
                                                        userSelectedDate)
                                                    .inDays;
                                                var age = days / 365;

                                                if (age > 7) {
                                                  controller.dateController
                                                          .value.text =
                                                      "${value.day.toString().padLeft(2, "0")}-${value.month.toString().padLeft(2, "0")}-${value.year}";
                                                  controller
                                                          .selectedDate.value =
                                                      "${value.year.toString()}-${value.month.toString().padLeft(2, "0")}-${value.day.toString().padLeft(2, "0")}";
                                                } else {
                                                  Utils.showMessage(
                                                      "Your age should be above 7.");
                                                }
                                              }
                                            });
                                          }
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
                                      SizedBox(height: 40.h),
                                      CommonAppButton(
                                        text: controller.isEditProfile.isTrue
                                            ? "Save Changes"
                                            : "Edit Profile",
                                        onClick: () {
                                          if (!controller.isEditProfile.value) {
                                            controller.isEditProfile.value =
                                                true;
                                          } else {
                                            controller.updateProfile();
                                          }
                                        },
                                        borderRadius: 10.r,
                                      ),
                                      if (controller.isEditProfile.isTrue)
                                        SizedBox(height: 30.h),
                                      if (controller.isEditProfile.isTrue)
                                        CommonAppButton(
                                          text: "Cancel",
                                          onClick: () {
                                            controller.isEditProfile.value =
                                                false;
                                          },
                                          borderRadius: 10.r,
                                          appColor: AppColors.colorWhite,
                                          textColor: AppColors.colorBlack,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Profile Image
                            Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                height: 86.h,
                                width: 86.w,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 86.w,
                                      height: 86.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.colorWhite,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: CommonCachedImage(
                                          filePath:
                                              controller.imageFile.value.path,
                                          imageUrl:
                                              controller.userImageShow.value,
                                          isCircle: true,
                                          boxFit: BoxFit.cover,
                                          width: 86.w,
                                          height: 86.h,
                                        ),
                                      ),
                                    ),
                                    if (controller.isEditProfile.isTrue)
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            Utils.showImagePickerBottomSheet(
                                                (imagePath) {
                                              if (imagePath != null) {
                                                controller.imageFile.value =
                                                    io.File(imagePath);
                                                final bytes = io.File(imagePath)
                                                    .readAsBytesSync();
                                                String img64 =
                                                    base64Encode(bytes);
                                                controller.userImage.value =
                                                    img64;
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 30.h,
                                            width: 30.w,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.color8A29C4,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.camera_alt,
                                                size: 18.w,
                                                color: AppColors.colorWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).paddingOnly(top: 125.h),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              ProfileController.isAdLoaded.value
                  ? CommonAdBanner(
                      width: controller.bannerAd.size.width.toDouble(),
                      height: controller.bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: controller.bannerAd),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      }),
    );
  }
}
