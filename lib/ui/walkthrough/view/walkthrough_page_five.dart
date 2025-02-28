import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WalkthroughPageFive extends StatelessWidget {
  const WalkthroughPageFive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            // margin: const EdgeInsets.all(20.0),
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
                image: const DecorationImage(image: AssetImage(AppImages.icWalkthroughImageFive),fit: BoxFit.fill),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(50.h))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 290.h,
              ),
              CommonTextWidget(
                text: "Strengthen Relationships",
                textSize: 20.sp,
                textAlign: TextAlign.center,
                color: AppColors.colorBlack,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 20.h,
              ),
              CommonTextWidget(
                text:
                "Strengthen bonds with timely birthday \n wishes.",
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
