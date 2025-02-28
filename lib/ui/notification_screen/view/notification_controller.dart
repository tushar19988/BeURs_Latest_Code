import 'package:beurs/data/network/models/template_response.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<TemplateResponse> notificationData = <TemplateResponse>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getTemplate();
    super.onInit();
  }

  void getTemplate() async {
    UserRepository().getTemplate().then((value) {
      value?.fold((l) {
        isLoading.value = false;
      }, (r) {
        isLoading.value = false;
        notificationData.value = r;
      });
    });
  }
}
