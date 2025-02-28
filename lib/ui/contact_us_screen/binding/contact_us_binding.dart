import 'package:beurs/ui/contact_us_screen/view/contact_us_controller.dart';
import 'package:get/get.dart';

class ContactUsBinding extends Bindings{
  @override
  void dependencies() {
Get.lazyPut(() => ContactUsController());
  }

}