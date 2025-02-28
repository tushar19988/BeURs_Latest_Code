import 'dart:io';
import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/ui/create_profile_screen/view/create_profile_controller.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_app_input.dart';
import 'package:beurs/widgets/common_cached_images.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateProfileScreen extends GetView<CreateProfileController> {
  const CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.closeKeyboard();
      },
      child: Obx(() {
        return Scaffold(
          body: SizedBox(
            height: Get.height,
            child: Stack(
              children: [
                Container(
                  height: 210.h,
                  width: Get.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.icDashboardBackImage),
                          fit: BoxFit.fill)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 46.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 70.h,
                            ),
                            Expanded(
                                child: Center(
                              child: CommonTextWidget(
                                text: "Create Profile",
                                textSize: 20.sp,
                                fontWeight: AppFontWeight.semiBold,
                                color: AppColors.colorWhite,
                              ),
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 125.h,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: SizedBox(
                        height: 633.h,
                        width: Get.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 590.h,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: AppColors.colorWhite,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 8.0,
                                        ),
                                      ]),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 75.h,
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18.w),
                                        child: Column(
                                          children: [
                                            CommonAppInput(
                                              height: 60.h,
                                              isEnable: true,
                                              hintText: "Enter Your User Name",
                                              textEditingController:
                                                  controller.userName.value,
                                              contentPaddingVertical: 16.h,
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            CommonAppInput(
                                              height: 60.h,
                                              // isEnable: true,
                                              contentPaddingVertical: 16.h,
                                              hintText:
                                                  "Enter Your Mobile Number",
                                              prefixIcon: Padding(
                                                padding: REdgeInsets.only(
                                                  left: 24.w,
                                                  right: 4.w,
                                                  top: 1.h,
                                                ),
                                                child: CommonTextWidget(
                                                  text: controller
                                                      .countryCode.value,
                                                  style: GoogleFonts.montserrat(
                                                    color:
                                                        AppColors.color013567,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              textEditingController:
                                                  controller.mobileNumber.value,
                                              isMobileNumber: true,
                                              textInputType:
                                                  TextInputType.phone,
                                              //  contentPaddingVertical: 16.h,
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            CommonAppInput(
                                              height: 60.h,
                                              isEnable: false,
                                              hintText: "Enter Your Email",
                                              textEditingController:
                                                  controller.userEmail.value,
                                              contentPaddingVertical: 16.h,
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Utils.selectDate(
                                                        context, DateTime.now())
                                                    .then((value) {
                                                  if (value != null) {
                                                    var userSelectedDate =
                                                        DateTime(
                                                            value.year,
                                                            value.month,
                                                            value.day);

                                                    //the duration difference form the selected date to now in days
                                                    var days = DateTime.now()
                                                        .difference(
                                                            userSelectedDate)
                                                        .inDays;

                                                    //the duration difference in years (the current age)
                                                    var age = days / 365;

                                                    if (age > 7) {
                                                      controller.dateController
                                                              .value.text =
                                                          "${value.day.toString().padLeft(2, "0")}-${value.month.toString().padLeft(2, "0")}-${value.year}";
                                                      controller.selectedDate
                                                              .value =
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
                                                hintText:
                                                    "Enter Your Date of Birth",
                                                textEditingController:
                                                    controller
                                                        .dateController.value,
                                                contentPaddingVertical: 16.h,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40.h,
                                            ),
                                            CommonAppButton(
                                              text: "Create Profile",
                                              onClick: () {
                                                if (controller
                                                    .checkSignInValidations()) {
                                                  controller.updateProfile();
                                                }
                                              },
                                              borderRadius: 10.r,
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
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
                                              color: AppColors.colorWhite),
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
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            Utils.showImagePickerBottomSheet(
                                                (imagePath) {
                                              if (imagePath != null) {
                                                controller.imageFile.value =
                                                    File(imagePath.toString());
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 30.h,
                                            width: 30.w,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.color8A29C4),
                                            child: Center(
                                              child: Icon(
                                                Icons.camera_alt,
                                                size: 18.w,
                                                color: AppColors.colorWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
