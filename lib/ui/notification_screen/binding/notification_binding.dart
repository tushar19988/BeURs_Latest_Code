import 'package:beurs/ui/notification_screen/view/notification_controller.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
  Get.lazyPut(() => NotificationController());
  }

}