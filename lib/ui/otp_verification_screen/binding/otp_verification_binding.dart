import 'package:beurs/ui/otp_verification_screen/view/otp_verification_controller.dart';
import 'package:get/get.dart';

class OTPVerificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OTPVerificationController());
  }

}