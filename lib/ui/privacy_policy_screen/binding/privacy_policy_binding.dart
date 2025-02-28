import 'package:beurs/ui/privacy_policy_screen/view/privacy_policy_controller.dart';
import 'package:get/get.dart';

class PrivacyPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyPolicyController());
  }
}
