import 'package:beurs/ui/faq/view/faq_controller.dart';
import 'package:beurs/widgets/common_app_bar.dart';
import 'package:beurs/widgets/common_expansion_tile.dart';
import 'package:beurs/widgets/common_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FaqScreen extends GetView<FaqController> {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        text: "FAQ",
        onBackClick: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.isTrue
              ? const Center(
                  child: CommonProgressIndicator(),
                )
              : ListView.builder(
                  padding: REdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  itemCount: controller.faqList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final uData = controller.faqList[index];
                    return CommonExpansionTile(
                      question: uData.question,
                      answer: uData.answer,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
