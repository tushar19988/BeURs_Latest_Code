import 'dart:io';

import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/app/app_route.dart';
import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/ui/dashboard_screen/view/dashboard_controller.dart';
import 'package:beurs/ui/dashboard_screen/view/home_screen/home_controller.dart';
import 'package:beurs/ui/dashboard_screen/view/profile_screen/profile_controller.dart';
import 'package:beurs/ui/dashboard_screen/view/subscription_screen/subscription_controller.dart';
import 'package:beurs/utility/constants.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_app_image.dart';
import 'package:beurs/widgets/common_cached_images.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        key: controller.scaffoldKey,
        drawer: getDrawerView(context),
        body: Container(
            child: controller.screenList[controller.screenIndex.value]),
        bottomNavigationBar: Container(
          height: 75.h,
          width: Get.height,
          decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.r),
                  topRight: Radius.circular(15.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10.0,
                ),
              ]),
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (controller.screenIndex.value != 0) {
                    HomeController homeController = Get.find<HomeController>();
                    controller.screenIndex.value = 0;
                    homeController.tapIndex.value = 0;
                    homeController.tabController!.animateTo(0);
                    // homeController.isLoading.value = true;
                    // homeController.askPermissions("");
                  }
                },
                child: Container(
                  color: AppColors.colorWhite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonAppImage(
                        imagePath: controller.screenIndex.value == 0
                            ? AppImages.icHomeFill
                            : AppImages.icHome,
                        height: 22.h,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CommonTextWidget(
                          text: "Home",
                          textSize: 14.sp,
                          color: controller.screenIndex.value == 0
                              ? AppColors.color9F45D4
                              : AppColors.color505050)
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (controller.screenIndex.value != 1) {
                    SubscriptionController subscriptionController =
                        Get.find<SubscriptionController>();
                    controller.screenIndex.value = 1;
                    subscriptionController.isLoading.value = true;
                    subscriptionController.subscriptionIndex.value = 0;
                    subscriptionController.getSubscriptionPlan();
                    // controller.subscriptionController.getSubscriptionPlan();
                  }
                },
                child: Container(
                  color: AppColors.colorWhite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonAppImage(
                        imagePath: controller.screenIndex.value == 1
                            ? AppImages.icSubscriptionFill
                            : AppImages.icSubscription,
                        height: 22.h,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CommonTextWidget(
                          text: "Subscription",
                          textSize: 14.sp,
                          color: controller.screenIndex.value == 1
                              ? AppColors.color9F45D4
                              : AppColors.color505050)
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  ProfileController profileController =
                      Get.find<ProfileController>();
                  controller.screenIndex.value = 2;
                  profileController.isLoading.value = true;
                  profileController.setUserData();
                  profileController.getUserProfile();
                },
                child: Container(
                  color: AppColors.colorWhite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonAppImage(
                        imagePath: controller.screenIndex.value == 2
                            ? AppImages.icProfileFill
                            : AppImages.icProfile,
                        height: 22.h,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CommonTextWidget(
                        text: "Profile",
                        textSize: 14.sp,
                        color: controller.screenIndex.value == 2
                            ? AppColors.color9F45D4
                            : AppColors.color505050,
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      );
    });
  }

  /// Create side drawer view
  Drawer getDrawerView(BuildContext context) {
    return Drawer(
      width: 373.w,
      backgroundColor: AppColors.colorWhite,
      child: Obx(() {
        return Column(
          children: [
            Container(
              height: 224.h,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40.r),
                      bottomLeft: Radius.circular(40.r)),
                  color: AppColors.color8125B8,
                  image: const DecorationImage(
                      image: AssetImage(AppImages.icSideMenuBack),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonCachedImage(
                          height: 75.h,
                          width: 75.w,
                          imageUrl: StorageManager().getUserImage().toString(),
                          //"https://i.ibb.co/Bz9sV52/Group-1000005503.png",
                          isCircle: true,
                          isBorder: true,
                          boxFit: BoxFit.cover,
                          borderColour: AppColors.colorWhite,
                        ),

                        /*Container(
                          width: 70.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image:  DecorationImage(image: FileImage(File(StorageManager().getUserImage().toString())), fit: BoxFit.cover)),
                        ),*/
                        GestureDetector(
                          onTap: () {
                            controller.openSideDrawer(false);
                          },
                          child: CommonAppImage(
                            imagePath: AppImages.icCancelIcon,
                            height: 15.h,
                            width: 15.w,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CommonTextWidget(
                      text: StorageManager().getName().toString(),
                      textSize: 25.sp,
                      color: AppColors.colorWhite,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  commonMenuTabs(
                      AppImages.icMyContactIcon, controller.myContact.value,
                      () {
                    controller.openSideDrawer(false);
                    HomeController homeController = Get.find<HomeController>();
                    controller.screenIndex.value = 0;
                    homeController.tabController!.animateTo(0);
                    homeController.tapIndex.value = 0;
                    homeController.isLoading.value = true;
                    homeController.contactData.clear();
                    homeController.askPermissions();
                    // homeController.adManager.loadInterstitialAd();
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  commonMenuTabs(
                      AppImages.icUpcomingBirthday, "Upcoming Birthdays", () {
                    controller.openSideDrawer(false);

                    HomeController homeController = Get.find<HomeController>();
                    homeController.adManager.loadInterstitialAd(
                      adUnitId: Platform.isAndroid
                          ? Constants.upComingBirthDayUnitID
                          : Constants.upComingBirthDayUnitIosID,
                    );

                    controller.screenIndex.value = 0;
                    homeController.tabController!.animateTo(1);
                    homeController.tapIndex.value = 1;

                    homeController.isUpcomingLoading.value = true;
                    homeController.getUpComingBirthday();
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  commonMenuTabs(AppImages.icPastWishes, "Past Wishes", () {
                    controller.openSideDrawer(false);

                    HomeController homeController = Get.find<HomeController>();
                    homeController.adManager.loadInterstitialAd(
                      adUnitId: Platform.isAndroid
                          ? Constants.pastWishUnitID
                          : Constants.pastWishUnitIosID,
                    );
                    controller.screenIndex.value = 0;
                    homeController.tabController!.animateTo(2);
                    homeController.tapIndex.value = 2;

                    homeController.isPastWishesLoading.value = true;
                    homeController.getPastWishes();
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  commonMenuTabs(AppImages.icFaq, "FAQ", () {
                    controller.openSideDrawer(false);
                    Get.toNamed(AppRoutes.faq);
                    // Get.toNamed(AppRoutes.webViewPage, arguments: {
                    //   "url": "https://beurs.in/faq-mobile.html",
                    //   "title": "FAQ"
                    // });
                    // Get.toNamed(AppRoutes.faqPage);
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  commonMenuTabs(AppImages.icPrivacyPolicy, "Privacy Policy",
                      () {
                    controller.openSideDrawer(false);
                    Get.toNamed(AppRoutes.privacyPolicy);
                    // Get.toNamed(AppRoutes.webViewPage, arguments: {"url": "https://beurs.in/privacy-mobile.html", "title": "Privacy Policy"});
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  commonMenuTabs(
                      AppImages.icTermsCondition, "Terms & Conditions", () {
                    controller.openSideDrawer(false);
                    Get.toNamed(AppRoutes.termsConditions);
                    // Get.toNamed(AppRoutes.webViewPage, arguments: {
                    //   "url": "https://beurs.in/tnc-mobile.html",
                    //   "title": "Terms & Conditions"
                    // });
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  commonMenuTabs(AppImages.icAboutUs, "About Us", () {
                    controller.openSideDrawer(false);
                    Get.toNamed(AppRoutes.aboutUs);
                    // Get.toNamed(AppRoutes.webViewPage, arguments: {
                    //   "url": "https://beurs.in/about-us-mobile.html",
                    //   "title": "About Us"
                    // });
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  commonMenuTabs(AppImages.icReview, "Review", () {
                    controller.openSideDrawer(false);
                    Get.toNamed(AppRoutes.reviewPage);
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  commonMenuTabs(AppImages.icContactUs, "Contact Us", () {
                    controller.openSideDrawer(false);
                    Get.toNamed(AppRoutes.contactUsPage);
                  }),
                ],
              ),
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: commonMenuTabs(AppImages.icLogOut, "Logout", () {
                Utils.confirmationBox(
                    context: context,
                    title: "Are you sure you want to Logout ?",
                    onCancelClick: () {
                      Get.back();
                    },
                    onSignOutClick: () {
                      StorageManager().clearSession();
                      StorageManager().setFromFresh(false);
                      Get.offAllNamed(AppRoutes.loginPage);
                    });
              }),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: commonMenuTabs(AppImages.icDelete, "Delete Account",
                  iconColor: Colors.red, textColor: Colors.red, () {
                Utils.confirmationBox(
                    context: context,
                    title: "Are you sure you want to Delete Account ?",
                    onCancelClick: () {
                      Get.back();
                    },
                    onSignOutClick: () {
                      controller.deleteAccount();
                      StorageManager().clearSession();
                      StorageManager().setFromFresh(false);
                      Get.offAllNamed(AppRoutes.loginPage);
                    });
              }),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        );
      }),
    );
  }

  Widget commonMenuTabs(String icon, String title, VoidCallback onClick,
      {Color textColor = AppColors.color505050, Color? iconColor}) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 45.h,
        width: Get.width,
        color: Colors.transparent,
        child: Row(
          children: [
            CommonAppImage(
              imagePath: icon,
              height: 30.h,
              width: 30.w,
              fit: BoxFit.contain,
              iconColor: iconColor,
            ),
            SizedBox(
              width: 18.w,
            ),
            CommonTextWidget(
              text: title,
              textSize: 18.sp,
              color: textColor,
            )
          ],
        ),
      ),
    );
  }
}
