import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebviewController extends GetxController {

  Rx<WebViewController> webViewController = WebViewController().obs;
  RxBool isLoading = true.obs;
  var argumentData = Get.arguments;
  RxString appBarTitle = "".obs;
  RxString url = "".obs;

  @override
  void onInit() {
    appBarTitle.value = argumentData['title'];
    url.value = argumentData['url'];
    print("Url :- ${url.value}");
    webViewController.value = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url.value));
    Future.delayed(const Duration(seconds: 3)).then((value) {
      isLoading.value = false;
    });

    super.onInit();
  }
}