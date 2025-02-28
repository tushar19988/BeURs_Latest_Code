import 'dart:io';

import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/app/app_route.dart';
import 'package:beurs/ui/dashboard_screen/view/home_screen/component/contact_component.dart';
import 'package:beurs/ui/dashboard_screen/view/home_screen/component/past_wish_component.dart';
import 'package:beurs/ui/dashboard_screen/view/home_screen/component/upcoming_birthday_component.dart';
import 'package:beurs/ui/dashboard_screen/view/home_screen/home_controller.dart';
import 'package:beurs/utility/constants.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_app_image.dart';
import 'package:beurs/widgets/common_cached_images.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.closeKeyboard();
      },
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: SizedBox(
          height: Get.height,
          child: Obx(
            () {
              return Stack(
                children: [
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
                          SizedBox(
                            height: 46.h,
                          ),
                          Row(
                            children: [
                              Obx(
                                () => CommonCachedImage(
                                  height: 70.h,
                                  width: 70.w,
                                  imageUrl: controller.profile.value,
                                  isCircle: true,
                                  boxFit: BoxFit.cover,
                                  borderColour: AppColors.colorWhite,
                                  isBorder: true,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Obx(
                                  () => CommonTextWidget(
                                    text: "Hey, ${controller.userName.value}",
                                    textSize: 16.sp,
                                    color: AppColors.colorWhite,
                                    fontWeight: AppFontWeight.light,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.notificationPage);
                                },
                                icon: CommonAppImage(
                                  imagePath: AppImages.icNotificationIcon,
                                  height: 22.h,
                                  width: 21.w,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.dashboardController
                                      .openSideDrawer(true);
                                },
                                icon: CommonAppImage(
                                  imagePath: AppImages.icMenuIcon,
                                  height: 13.h,
                                  width: 21.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Welcome! Back",
                                style: TextStyle(
                                    fontFamily: "frisky",
                                    fontSize: 24.sp,
                                    color: AppColors.colorWhite),
                              ),
                              // Text(
                              //   "${controller.subscriptionname.value == "" ? "Free plan" : controller.subscriptionname.value} - ${controller.subScriptionCount.value}",
                              //   style: TextStyle(fontFamily: "frisky", fontSize: 20.sp, color: AppColors.colorWhite),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 175.h,
                          ),
                          Container(
                            height: 61.h,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.colorWhite,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 8.0,
                                  ),
                                ]),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: TabBar(
                                onTap: (value) {
                                  controller.tapIndex.value = value;
                                  if (value == 0) {
                                    controller.tabController!.animateTo(0);
                                    // controller.adManager.loadInterstitialAd();
                                  } else if (value == 1) {
                                    controller.tabController!.animateTo(1);
                                    controller.isUpcomingLoading.value = true;
                                    controller.adManager.loadInterstitialAd(
                                      adUnitId: Platform.isAndroid
                                          ? Constants.upComingBirthDayUnitID
                                          : Constants.upComingBirthDayUnitIosID,
                                    );
                                    controller.getUpComingBirthday();
                                  } else if (value == 2) {
                                    controller.tabController!.animateTo(2);
                                    controller.isPastWishesLoading.value = true;
                                    controller.adManager.loadInterstitialAd(
                                      adUnitId: Platform.isAndroid
                                          ? Constants.pastWishUnitID
                                          : Constants.pastWishUnitIosID,
                                    );

                                    controller.getPastWishes();
                                  }
                                },
                                dividerColor: AppColors.colorWhite,
                                indicatorColor: AppColors.colorWhite,
                                labelPadding:
                                    EdgeInsets.symmetric(horizontal: 2.w),
                                tabAlignment: TabAlignment.center,
                                tabs: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: controller.tapIndex.value == 0
                                          ? AppColors.color8A29C4
                                          : AppColors.colorWhite,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    height: 45.h,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: CommonTextWidget(
                                          text: "My Contacts",
                                          textSize: 14.sp,
                                          color: controller.tapIndex.value == 0
                                              ? AppColors.colorWhite
                                              : AppColors.color9C9C9C,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: controller.tapIndex.value == 1
                                          ? AppColors.color8A29C4
                                          : AppColors.colorWhite,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    height: 45.h,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: CommonTextWidget(
                                          text: "Upcoming Birthdays",
                                          textSize: 14.sp,
                                          textAlign: TextAlign.center,
                                          color: controller.tapIndex.value == 1
                                              ? AppColors.colorWhite
                                              : AppColors.color9C9C9C,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: controller.tapIndex.value == 2
                                          ? AppColors.color8A29C4
                                          : AppColors.colorWhite,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    height: 45.h,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                        ),
                                        child: CommonTextWidget(
                                          text: "Scheduled",
                                          textSize: 14.sp,
                                          color: controller.tapIndex.value == 2
                                              ? AppColors.colorWhite
                                              : AppColors.color9C9C9C,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: controller.tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                ContactComponent(homeController: controller),
                                UpcomingBirthdayComponent(
                                  homeController: controller,
                                ),
                                PastWishComponent(homeController: controller),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
