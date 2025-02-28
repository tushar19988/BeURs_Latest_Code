import 'package:beurs/ui/webview/view/webview_controller.dart';
import 'package:get/get.dart';

class WebViewBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => WebviewController());
  }
}