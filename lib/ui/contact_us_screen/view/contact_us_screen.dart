import 'package:beurs/app/app_colors.dart';
import 'package:beurs/ui/contact_us_screen/view/contact_us_controller.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_app_bar.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUsScreen extends GetView<ContactUsController> {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.closeKeyboard();
      },
      child: Scaffold(
        appBar: CommonAppbar(
          text: "Contact us",
          onBackClick: () {
            Get.back();
          },
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              CommonTextWidget(
                text: "Please share your query or concern and our team will get in touch with you shortly.",
                textSize: 16.sp,
              ),
              SizedBox(
                height: 14.h,
              ),
              Container(
                width: Get.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: AppColors.colorWhite, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8.0,
                  ),
                ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 14.h,
                      ),
                      Container(
                        height: 200.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r), color: AppColors.colorWhite, border: Border.all(color: AppColors.colorE9E9E9)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 23.w, top: 0.h),
                          child: TextField(
                            controller: controller.contactUsMessageController.value,
                            maxLines: 7,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "How can we help you?",
                                hintStyle: GoogleFonts.inter(color: AppColors.color9C9C9C, fontSize: 14.sp)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CommonAppButton(
                        text: "Submit",
                        onClick: () {
                          controller.onContactUs();
                        },
                        borderRadius: 10.r,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
