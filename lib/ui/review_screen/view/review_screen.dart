import 'package:beurs/app/app_colors.dart';
import 'package:beurs/ui/review_screen/view/review_controller.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_app_bar.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewScreen extends GetView<ReviewController> {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.closeKeyboard();
      },
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        appBar: CommonAppbar(
          text: "Review",
          onBackClick: () {
            Get.back();
          },
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  CommonTextWidget(
                      text: "Your feedback is valuable for us 😉😉",
                      textSize: 20.sp),
                  SizedBox(
                    height: 20.h,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    glow: false,
                    itemSize: 35.w,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      size: 10.w,
                      color: AppColors.colorFF8F0E,
                    ),
                    onRatingUpdate: (rating) {
                      controller.rating.value = rating;
                      print(rating);
                    },
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(text: "FEEDBACK", textSize: 18.sp),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        height: 200.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.colorWhite,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 15.0,
                              ),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 23.w, right: 23.w, top: 5.h),
                          child: TextField(
                            controller: controller.feedbackController.value,
                            maxLines: 7,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write Your Feedback",
                                hintStyle: GoogleFonts.inter(
                                    color: AppColors.colorCCCCCC,
                                    fontSize: 14.sp)),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  CommonAppButton(
                    text: "Submit",
                    onClick: () {
                      controller.onReview();
                    },
                    borderRadius: 10.r,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
