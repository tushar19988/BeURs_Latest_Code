import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/ui/notification_screen/view/notification_controller.dart';
import 'package:beurs/widgets/common_app_bar.dart';
import 'package:beurs/widgets/common_progress_indicator.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CommonAppbar(
          text: "Notification",
          onBackClick: () {
            Get.back();
          },
        ),
        body: Column(
          children: [
            Expanded(
              child:controller.isLoading.isTrue?Center(child: CommonProgressIndicator(),): ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 12.h),
                itemCount: controller.notificationData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      CommonTextWidget(
                        text: controller.notificationData[index].msgstr != ""
                            ? controller.notificationData[index].msgstr
                            .toString()
                            : " No Message",
                        textSize: 14.sp,
                        color: AppColors.color505050,
                        fontWeight: AppFontWeight.light,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      index == controller.notificationData.length - 1
                          ? Container()
                          : Container(
                        height: 1.h,
                        width: Get.width,
                        color: AppColors.colorE9E9E9,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
