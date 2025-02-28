import 'package:beurs/ui/review_screen/view/review_controller.dart';
import 'package:get/get.dart';

class ReviewBinding extends Bindings{
  @override
  void dependencies() {
Get.lazyPut(() => ReviewController());
  }

}