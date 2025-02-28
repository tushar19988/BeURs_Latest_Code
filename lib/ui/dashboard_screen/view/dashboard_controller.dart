import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/data/network/client/api_client.dart';
import 'package:beurs/data/network/client/api_provider.dart';
import 'package:beurs/ui/dashboard_screen/view/home_screen/home_screen.dart';
import 'package:beurs/ui/dashboard_screen/view/profile_screen/profile_screen.dart';
import 'package:beurs/ui/dashboard_screen/view/subscription_screen/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt screenIndex = 0.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxString myContact = "My Contacts".obs;
  RxString userId = "".obs;

  RxList screenList = [
    const HomeScreen(),
    const SubscriptionScreen(),
    const ProfileScreen()
  ].obs;

  @override
  void onReady() {
    super.onReady();
    getUserProfile();
  }

  /// Open side drawer
  void openSideDrawer(bool value) {
    if (value) {
      scaffoldKey.currentState?.openDrawer();
    } else {
      scaffoldKey.currentState?.closeDrawer();
    }
  }

  void getUserProfile() async {
    userId.value = StorageManager().getUserId().toString();
  }

  deleteAccount() async {
    final apiProvider = ApiProvider();

    // No need for a body in DELETE request, pass null
    var response = await apiProvider
        .deleteMethod("${ApiClient.getDeleteUser}/${userId.value}");

    // Checking the response
    response?.fold(
      (error) {
        // Handle error
        print('Error: $error');
      },
      (data) {
        // Handle success
        print('Success: $data');
      },
    );
  }
}
