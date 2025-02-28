import 'package:beurs/ui/splash_screen/view/splash_controller.dart';
import 'package:get/get.dart';




class SplashBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SplashController());
  }

}