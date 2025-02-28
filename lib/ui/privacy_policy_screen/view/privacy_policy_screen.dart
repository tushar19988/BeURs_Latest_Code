import 'package:beurs/ui/privacy_policy_screen/view/privacy_policy_controller.dart';
import 'package:beurs/widgets/common_app_bar.dart';
import 'package:beurs/widgets/common_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        text: "Privacy Policy",
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
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: HtmlWidget(
                    controller.aboutUsResponse.htmlData ?? "",
                  ),
                ),
        ),
      ),
    );
  }
}
