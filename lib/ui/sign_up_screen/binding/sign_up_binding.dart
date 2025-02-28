import 'package:beurs/ui/sign_up_screen/view/sign_up_controller.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }

}