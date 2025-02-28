import 'package:beurs/ui/dashboard_screen/view/dashboard_controller.dart';
import 'package:beurs/ui/dashboard_screen/view/home_screen/home_controller.dart';
import 'package:beurs/ui/dashboard_screen/view/profile_screen/profile_controller.dart';
import 'package:beurs/ui/dashboard_screen/view/subscription_screen/subscription_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SubscriptionController());
    Get.lazyPut(() => ProfileController());

  }

}