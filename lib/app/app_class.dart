import 'package:get/get_rx/src/rx_types/rx_types.dart';

/// Top level app class
class AppClass {
  static final AppClass _singleton = AppClass._internal();

  factory AppClass() {
    return _singleton;
  }

  AppClass._internal();

  RxBool isShowLoading = false.obs;

  /// Show-hide top level loading
  void showLoading(bool value) {
    isShowLoading.value = value;
  }
}
