import 'package:beurs/ui/terms_conditions_screen/view/term_condition_controller.dart';
import 'package:get/get.dart';

class TermConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermConditionController());
  }
}
