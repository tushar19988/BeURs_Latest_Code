import 'package:beurs/app/app_colors.dart';
import 'package:beurs/ui/webview/view/webview_controller.dart';
import 'package:beurs/widgets/common_app_bar.dart';
import 'package:beurs/widgets/common_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends GetView<WebviewController> {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: AppColors.colorWhite,
        appBar: CommonAppbar(
          text: controller.appBarTitle.value,
          onBackClick: () {
            Get.back();
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return controller.isLoading.value
                  ? const Expanded(child: Center(child: CommonProgressIndicator()))
                  : Expanded(
                      child: WebViewWidget(
                        controller: controller.webViewController.value,
                      ),
                    );
            })
          ],
        ));
  }
}
