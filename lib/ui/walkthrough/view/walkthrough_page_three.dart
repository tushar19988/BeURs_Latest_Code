import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WalkthroughPageThree extends StatelessWidget {
  const WalkthroughPageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            // margin: const EdgeInsets.all(20.0),
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
                image: const DecorationImage(image: AssetImage(AppImages.icWalkthroughImageThree),fit: BoxFit.fill),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(50.h))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 290.h,),
              CommonTextWidget(
                text: "Simplify Celebrations",
                textSize: 20.sp,
                textAlign: TextAlign.center,
                color: AppColors.colorBlack,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 19.h,
              ),
              CommonTextWidget(
                text:
                "Setting reminders for every birthday  \ncan be overwhelming.",
                textSize: 14.sp,
                textAlign: TextAlign.center,
                color: AppColors.color505050,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
        ],
      ),
    );
  }
}
