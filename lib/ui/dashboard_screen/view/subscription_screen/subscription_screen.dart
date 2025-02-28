import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/app/app_route.dart';
import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/ui/dashboard_screen/view/subscription_screen/subscription_controller.dart';
import 'package:beurs/widgets/common_ad_banner.dart';
import 'package:beurs/widgets/common_app_image.dart';
import 'package:beurs/widgets/common_cached_images.dart';
import 'package:beurs/widgets/common_progress_indicator.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SubscriptionScreen extends GetView<SubscriptionController> {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: Column(
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
                      children: [
                        CommonCachedImage(
                          height: 70.h,
                          width: 70.w,
                          imageUrl: StorageManager().getUserImage().toString(),
                          isCircle: true,
                          boxFit: BoxFit.cover,
                          borderColour: AppColors.colorWhite,
                          isBorder: true,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            child: CommonTextWidget(
                          text: "Hey, ${StorageManager().getName().toString()}",
                          textSize: 16.sp,
                          color: AppColors.colorWhite,
                          fontWeight: AppFontWeight.light,
                        )),
                        SizedBox(
                            height: 33.h,
                            width: 26.w,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.notificationPage);
                              },
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: CommonAppImage(
                                      imagePath: AppImages.icNotificationIcon,
                                      height: 22.h,
                                      width: 21.w,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          width: 20.w,
                        ),
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
                        )
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      "Welcome! Back",
                      style: TextStyle(
                          fontFamily: "frisky",
                          fontSize: 24.sp,
                          color: AppColors.colorWhite),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Expanded(
                      child: controller.isLoading.isTrue
                          ? const Center(
                              child: CommonProgressIndicator(),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: controller.subscriptionList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Obx(() {
                                  return Column(
                                    children: [
                                      commonSubscriptionWidget(
                                          index,
                                          controller
                                              .subscriptionList[index].planprice
                                              .toString(),
                                          controller
                                              .subscriptionList[index].features
                                              .toString(), () {
                                        controller.subscriptionIndex.value =
                                            index;
                                        controller.selectedSubscriptionPrice
                                            .value = int.parse(controller
                                                .subscriptionList[index]
                                                .planprice
                                                .toString()) ??
                                            0;
                                        controller.planDescription.value =
                                            controller.subscriptionList[index]
                                                    .msgcountstr ??
                                                "";
                                      }),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      // CommonAdBanner(
                                      //   width: controller.bannerAd.size.width
                                      //       .toDouble(),
                                      //   height: controller.bannerAd.size.height
                                      //       .toDouble(),
                                      //   child:
                                      //       AdWidget(ad: controller.bannerAd),
                                      // ),
                                    ],
                                  );
                                });
                              })),
                  SizedBox(
                    height: 20.h,
                  ),
                  // CommonAppButton(
                  //   text: "Subscribe Now",
                  //   onClick: () {
                  //     controller.getSubscription();
                  //   },
                  //   borderRadius: 12.r,
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                ],
              ),
            ))
          ],
        ),
      );
    });
  }

  Widget commonSubscriptionWidget(
      int index, String price, String description, VoidCallback onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: AppColors.colorWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.23),
                blurRadius: 20.0,
              ),
            ],
            borderRadius: BorderRadius.circular(12.r),
            border: controller.subscriptionIndex.value == index
                ? Border.all(width: 1.w, color: AppColors.color8A29C4)
                : null),
        child: Row(
          children: [
            SizedBox(
              width: 40.w,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CommonTextWidget(
                      text: "INR.$price",
                      textSize: 24.sp,
                      color: AppColors.color8A29C4,
                      fontWeight: AppFontWeight.medium,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: CommonTextWidget(
                        text:
                            "/${controller.subscriptionList[index].validityperiod.toString()}",
                        textSize: 14.sp,
                        color: AppColors.color505050,
                        fontWeight: AppFontWeight.regular,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                HtmlWidget(
                  description,
                  textStyle: TextStyle(fontSize: 15.sp),
                ),
                // CommonTextWidget(text: description,
                //   textSize: 15.sp,
                //   color: AppColors.color505050,
                //   fontWeight: AppFontWeight.regular,),
                SizedBox(
                  width: 3.w,
                ),
              ],
            )),
            SizedBox(
              width: 50.w,
            ),
            controller.subscriptionIndex.value == index
                ? Container(
                    width: 86.w,
                    decoration: BoxDecoration(
                        color: AppColors.color8A29C4,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12.r),
                            bottomRight: Radius.circular(12.r))),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: AppColors.colorWhite,
                        size: 30.w,
                      ),
                    ),
                  )
                : SizedBox(
                    width: 86.w,
                  )
          ],
        ),
      ),
    );
  }
}
