import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/ui/dashboard_screen/view/home_screen/home_controller.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_app_image.dart';
import 'package:beurs/widgets/common_progress_indicator.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpcomingBirthdayComponent extends StatelessWidget {
  HomeController homeController;
  UpcomingBirthdayComponent({Key? key, required this.homeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 22.h,
        ),
        CommonTextWidget(text: "Keep the following", textSize: 14.sp),
        SizedBox(
          height: 5.h,
        ),
        CommonTextWidget(
            text: "birthdays in mind this month! 😉😉", textSize: 14.sp),
        Obx(() {
          return Expanded(
            child: homeController.isUpcomingLoading.value
                ? const Center(
                    child: CommonProgressIndicator(),
                  )
                : homeController.upComingResponse.isEmpty
                    ? Center(
                        child: CommonTextWidget(
                          text:
                              "We are waiting for upcoming birthdays for you.",
                          textSize: 14.sp,
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(top: 15.h),
                        itemCount: homeController.upComingResponse.length,
                        itemBuilder: (BuildContext context, int index) {
                          String inputDate = homeController
                              .upComingResponse[index].wishdate
                              .toString();
                          DateTime dateTime = DateTime.parse(inputDate);
                          DateFormat outputFormat = DateFormat('d MMMM yyyy');
                          String upcomingFormattedDate =
                              outputFormat.format(dateTime);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget(
                                text: upcomingFormattedDate,
                                textSize: 14.sp,
                                color: index == 0
                                    ? AppColors.color9F45D4
                                    : AppColors.color9C9C9C,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: homeController
                                    .upComingResponse[index].userdata!.length,
                                itemBuilder:
                                    (BuildContext context, int indexX) {
                                  return SizedBox(
                                    height: 90.h,
                                    width: Get.width,
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: 1.5.w,
                                                color: AppColors.colorE9E9E9,
                                              ),
                                            ),
                                            Container(
                                              height: 44.h,
                                              width: 44.h,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.colorFD9904,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    blurRadius: 10.0,
                                                  ),
                                                ],
                                              ),
                                              child: CommonAppImage(
                                                imagePath: AppImages.icGiftIcon,
                                                height: 38.h,
                                                width: 38.h,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: 1.5.w,
                                                color: AppColors.colorE9E9E9,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 13.h,
                                              ),
                                              CommonTextWidget(
                                                text: homeController
                                                    .upComingResponse[index]
                                                    .userdata![indexX]
                                                    .username
                                                    .toString(),
                                                textSize: 14.sp,
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              CommonTextWidget(
                                                text:
                                                    "Wish them a plenty of perfect years to come!!",
                                                textSize: 14.sp,
                                                color: AppColors.color505050,
                                              ),
                                              // Row(
                                              //   children: [
                                              //     Expanded(
                                              //       child: Column(
                                              //         crossAxisAlignment: CrossAxisAlignment.start,
                                              //         children: [
                                              //           CommonTextWidget(
                                              //             text: homeController.upComingResponse[index].userdata![indexX].username.toString(),
                                              //             textSize: 14.sp,
                                              //           ),
                                              //           SizedBox(
                                              //             height: 5.h,
                                              //           ),
                                              //           CommonTextWidget(
                                              //             text: "Wish them a plenty of perfect years to come!!",
                                              //             textSize: 14.sp,
                                              //             color: AppColors.color505050,
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     SizedBox(
                                              //       width: 20.w,
                                              //     ),
                                              //     CommonAppButton(
                                              //       text: "Send Gift",
                                              //       onClick: () {},
                                              //       borderRadius: 10.r,
                                              //       width: 114.w,
                                              //       height: 45.h,
                                              //       fontSize: 14.sp,
                                              //     ),
                                              //   ],
                                              // ),
                                              Expanded(child: Container()),
                                              indexX ==
                                                      homeController
                                                              .upComingResponse
                                                              .length -
                                                          1
                                                  ? Container()
                                                  : Container(
                                                      height: 1.3.h,
                                                      width: Get.width,
                                                      color:
                                                          AppColors.colorE9E9E9,
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          );
                        },
                      ),
          );
        })
      ],
    );
  }
}
