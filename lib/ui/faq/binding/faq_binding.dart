import 'package:beurs/ui/faq/view/faq_controller.dart';
import 'package:get/get.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FaqController());
  }
}
