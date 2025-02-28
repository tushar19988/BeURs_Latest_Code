import 'dart:async';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_app_image.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';

import '../app/app_colors.dart';

class Utils {
  Utils._();

  /// Close keyboard
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Show common snack bar messages
  static void showMessage(String message, {snackPosition = SnackPosition.TOP}) {
    if (Get.context != null) {
      Flushbar(
        key: Key(message),
        message: message,
        borderRadius: BorderRadius.circular(10.r),
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        backgroundColor: AppColors.color8A29C4,
        flushbarPosition: FlushbarPosition.TOP,
        borderColor: AppColors.colorWhite,
        duration: const Duration(seconds: 3),
      ).show(Get.context!);
    } else {
      debugPrint("Error: Get.context is null, unable to show Flushbar.");
    }
  }

  /// Get device id for device
  static Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return Future.value(iosDeviceInfo.identifierForVendor);
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return Future.value(androidDeviceInfo.id);
    } else {
      return '';
    }
  }

  static Future<DateTime?> selectDate(
      BuildContext context, DateTime selectedDate) async {
    DateTime? pickedDate;

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 330,
          child: Scaffold(
            backgroundColor:
                CupertinoColors.systemBackground.resolveFrom(context),
            body: SafeArea(
              top: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date of Birth',
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            color: AppColors.colorBlack,
                            fontWeight: AppFontWeight.semiBold,
                          ),
                          selectionColor: Colors.transparent,
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(color: CupertinoColors.activeBlue),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CupertinoDatePicker(
                      initialDateTime: selectedDate,
                      mode: CupertinoDatePickerMode.date,
                      dateOrder: DatePickerDateOrder.dmy,
                      onDateTimeChanged: (DateTime newDate) {
                        pickedDate = newDate;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    return pickedDate ?? selectedDate;
  }

  /// Select image from camera or gallery
  static void showImagePickerBottomSheet(
      Function(String? imagePath) onImagePicked) {
    Get.bottomSheet(
      Wrap(
        children: [
          SizedBox(
            height: 200.h,
            child: Column(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      "Select From",
                      style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: AppColors.colorWhite,
                          fontWeight: AppFontWeight.semiBold),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      size: 24.r,
                      color: AppColors.colorWhite,
                    ),
                    title: Text(
                      "Camera",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.colorWhite,
                          fontWeight: AppFontWeight.semiBold),
                    ),
                    onTap: () async {
                      Get.back();
                      final XFile? image = await ImagePicker().pickImage(
                          source: ImageSource.camera, imageQuality: 25);
                      if (image != null) {
                        onImagePicked.call(image.path);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: const Icon(
                      Icons.image,
                      size: 24,
                      color: AppColors.colorWhite,
                    ),
                    title: Text(
                      "Gallery",
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.colorWhite,
                          fontWeight: AppFontWeight.semiBold),
                    ),
                    onTap: () async {
                      Get.back();
                      final XFile? image = await ImagePicker().pickImage(
                          source: ImageSource.gallery, imageQuality: 25);
                      if (image != null) {
                        onImagePicked.call(image.path);
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
      barrierColor: AppColors.colorBlack.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: AppColors.to.primaryColor,
      enableDrag: false,
    );
  }

  static void confirmationBox(
      {BuildContext? context,
      required String title,
      required void Function() onSignOutClick,
      required void Function() onCancelClick,
      Key? key}) {
    showModalBottomSheet(
      backgroundColor: AppColors.colorWhite,
      useSafeArea: false,
      context: context!,
      isDismissible: true,
      builder: (context) {
        return SizedBox(
          height: 281.h,
          child: Column(
            children: [
              Center(
                child: Container(
                    height: 88.w,
                    width: 88.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(25.w),
                      child: CommonAppImage(
                        imagePath: AppImages.icSignOut,
                        fit: BoxFit.contain,
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w, right: 40.w),
                child: CommonTextWidget(
                  text: title,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  textSize: 18.sp,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  CommonAppButton(
                    textColor: AppColors.colorWhite,
                    height: 52.h,
                    width: 114.w,
                    text: "Yes",
                    borderRadius: 10.r,
                    onClick: onSignOutClick,
                  ),
                  CommonAppButton(
                    textColor: AppColors.colorBlack,
                    text: "No",
                    height: 52.h,
                    width: 114.w,
                    onClick: onCancelClick,
                    appColor: Colors.transparent,
                    borderColor: AppColors.to.textColor,
                    borderRadius: 10.r,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  static void showFreeMessageCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        double progress = 0.0;
        Timer? timer;

        return StatefulBuilder(
          builder: (context, setState) {
            timer ??= Timer.periodic(Duration(milliseconds: 50), (timer) {
              progress += 0.01;
              if (progress >= 1.0) {
                progress = 1.0;
                timer.cancel();
                Get.back();
              }
              setState(() {});
            });

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8.0), // Adjust the radius as needed
              ),
              actionsPadding: EdgeInsets.zero,
              actions: [
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  color: AppColors.color8A29C4,
                ),
              ],
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        timer?.cancel();
                        Get.back();
                      },
                      child: const Icon(
                        Icons.cancel,
                        color: AppColors.color8125B8,
                      ),
                    ),
                  ),
                  CommonAppImage(
                    imagePath: AppImages.icSubscribe,
                    fit: BoxFit.cover,
                    height: 70.w,
                    width: 70.w,
                  ),
                  SizedBox(height: 10),
                  const CommonTextWidget(text: "Oops!!", textSize: 18),
                  SizedBox(height: 10),
                  const CommonTextWidget(
                    text: "🎉 Thank You for Using Our Services! 🎉",
                    fontWeight: FontWeight.bold,
                    textSize: 16,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CommonTextWidget(
                      text:
                          "🎉 Your FREE Plan Credits Are Used Up! ✨ Unlock Unlimited Birthday Wish Credits by Subscribing Now! ✨📅 Never miss a special moment. Subscribe today and keep spreading joy!",
                      fontWeight: FontWeight.w400,
                      textSize: 14,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  const CommonTextWidget(
                    text: "🥳 Subscribe Now!",
                    fontWeight: FontWeight.bold,
                    textSize: 16,
                    color: AppColors.color8A29C4,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static FadeAnimatedText fadeAnimatedText(
      {required String text,
      TextAlign? textAlign,
      TextStyle? textStyle,
      Duration? duration}) {
    return FadeAnimatedText(text,
        textAlign: TextAlign.center,
        textStyle: GoogleFonts.inter(
          color: AppColors.color8A29C4,
          fontSize: 15.sp,
          fontWeight: AppFontWeight.regular,
        ),
        duration: Duration(milliseconds: 4000));
  }
}
