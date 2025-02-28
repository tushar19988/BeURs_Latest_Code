import 'package:beurs/ui/create_profile_screen/view/create_profile_controller.dart';
import 'package:get/get.dart';

class CreateProfileBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => CreateProfileController());
  }

}//