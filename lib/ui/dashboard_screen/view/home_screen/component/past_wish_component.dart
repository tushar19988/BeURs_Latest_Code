import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/ui/dashboard_screen/view/home_screen/home_controller.dart';
import 'package:beurs/widgets/common_app_image.dart';
import 'package:beurs/widgets/common_progress_indicator.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PastWishComponent extends StatelessWidget {
  HomeController homeController;

  PastWishComponent({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return Expanded(
              child: homeController.isPastWishesLoading.value
                  ? const Center(child: CommonProgressIndicator())
                  : homeController.pastWishesResponse.isEmpty
                      ? Center(
                          child: CommonTextWidget(
                              text:
                                  "There is no past wishes for you at the moment.",
                              textSize: 14.sp),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 25.h),
                          itemBuilder: (BuildContext context, int index) {
                            String inputDate = homeController
                                .pastWishesResponse[index].wishdate
                                .toString();
                            DateTime dateTime = DateTime.parse(inputDate);
                            DateFormat outputFormat = DateFormat('d MMMM yyyy');
                            String formattedDate =
                                outputFormat.format(dateTime);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextWidget(
                                  text: formattedDate,
                                  textSize: 14.sp,
                                  color: AppColors.color9C9C9C,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int indexX) {
                                    return SizedBox(
                                      height: 92,
                                      width: Get.width,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Flexible(
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
                                                  imagePath:
                                                      AppImages.icGiftIcon,
                                                  height: 38.h,
                                                  width: 38.h,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Flexible(
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
                                              children: [
                                                13.verticalSpace,
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CommonTextWidget(
                                                            text: homeController
                                                                .pastWishesResponse[
                                                                    index]
                                                                .userdata![
                                                                    indexX]
                                                                .username
                                                                .toString(),
                                                            textSize: 14.sp,
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          CommonTextWidget(
                                                            text: homeController
                                                                        .pastWishesResponse[
                                                                            index]
                                                                        .userdata![
                                                                            indexX]
                                                                        .birthdaymsg ==
                                                                    ""
                                                                ? "Wish them a plenty of perfect years to come!!"
                                                                : homeController
                                                                    .pastWishesResponse[
                                                                        index]
                                                                    .userdata![
                                                                        indexX]
                                                                    .birthdaymsg!,
                                                            textSize: 14.sp,
                                                            maxLines: 6,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: AppColors
                                                                .color505050,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 40.w,
                                                    ),
                                                  ],
                                                ),
                                                Expanded(child: Container()),
                                                indexX == 2
                                                    ? Container()
                                                    : Container(
                                                        height: 1.3.h,
                                                        width: Get.width,
                                                        color: AppColors
                                                            .colorE9E9E9,
                                                      ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: homeController
                                      .pastWishesResponse[index]
                                      .userdata!
                                      .length,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            );
                          },
                          itemCount: homeController.pastWishesResponse.length,
                        ));
        })
      ],
    );
  }
}
