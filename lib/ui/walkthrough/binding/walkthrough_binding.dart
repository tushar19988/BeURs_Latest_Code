import 'package:beurs/ui/walkthrough/view/walkthrough_controller.dart';
import 'package:get/get.dart';

class WalkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalkthroughController());
  }
}