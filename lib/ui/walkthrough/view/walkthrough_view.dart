import 'package:beurs/app/app_colors.dart';
import 'package:beurs/ui/walkthrough/view/walkthrough_controller.dart';
import 'package:beurs/ui/walkthrough/view/walkthrough_page_five.dart';
import 'package:beurs/ui/walkthrough/view/walkthrough_page_four.dart';
import 'package:beurs/ui/walkthrough/view/walkthrough_page_one.dart';
import 'package:beurs/ui/walkthrough/view/walkthrough_page_three.dart';
import 'package:beurs/ui/walkthrough/view/walkthrough_page_two.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WalkthroughPage extends GetView<WalkthroughController> {
  const WalkthroughPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
            children: [
              PageView(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.slideIndex.value = index;
                },
                children: const <Widget>[
                  WalkthroughPageOne(),
                  WalkthroughPageTwo(),
                  WalkthroughPageThree(),
                  WalkthroughPageFour(),
                  WalkthroughPageFive(),
                ], //, WalkthroughPageThree()
              ),
              SizedBox(
                height: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 1.3,
                      ),
                      controller.slideIndex.value != 4
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < 5; i++)
                                      i == controller.slideIndex.value
                                          ? _buildPageIndicator(true)
                                          : _buildPageIndicator(false),
                                  ],
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonAppButton(
                                      text: "Skip",
                                      width: 115.w,
                                      borderRadius: 10.0,
                                      height: 45.h,
                                      fontSize: 14.sp,
                                      textColor: AppColors.colorBlack,
                                      appColor: Colors.transparent,
                                      fontWeight: FontWeight.w600,
                                      onClick: () {
                                        controller.goToSkipGetStarted();
                                      },
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    CommonAppButton(
                                      text: "Next",
                                      width: 115.w,
                                      borderRadius: 10.0,
                                      height: 45.h,
                                      fontSize: 14.sp,
                                      textColor: AppColors.colorWhite,
                                      appColor: AppColors.color9F45D4,
                                      fontWeight: FontWeight.w600,
                                      onClick: () {
                                        controller.slideIndex++;
                                        controller.goToNextPage(
                                            controller.slideIndex.value);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : GestureDetector(
                              onTap: () {
                                //Get.offAndToNamed(AppRoutes.loginPage);
                                controller.goToSkipGetStarted();
                              },
                              child: Container(
                                height: 62.h,
                                width: 236.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.color9F45D4,
                                ),
                                child: CommonTextWidget(
                                  text: "Get Started",
                                  textSize: 16.sp,
                                  color: AppColors.colorWhite,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                      SizedBox(
                        height: controller.slideIndex.value != 4 ? 50.h : 35.h,
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      alignment: Alignment.center,
      width: 10.w,
      height: 10.w,
      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      decoration: BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          color: isCurrentPage ? AppColors.color9F45D4 : AppColors.colorF1D9FF),
    );
  }
}
