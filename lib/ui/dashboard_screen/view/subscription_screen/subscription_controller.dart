import 'dart:io';

import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/data/network/models/subscription_plan_response.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/ui/dashboard_screen/view/dashboard_controller.dart';
import 'package:beurs/ui/dashboard_screen/view/home_screen/home_controller.dart';
import 'package:beurs/utility/constants.dart';
import 'package:beurs/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionController extends GetxController {
  DashboardController dashboardController = Get.find<DashboardController>();
  RxInt subscriptionIndex = 0.obs;
  RxString subscriptionId = "".obs;
  RxInt selectedSubscriptionPrice = 0.obs;
  RxString planDescription = "".obs;
  RxList<SubscriptionPlanResponse> subscriptionList =
      <SubscriptionPlanResponse>[].obs;

  RxBool isLoading = true.obs;

  /// Short Banner
  // late final BannerAd bannerAd;
  // final BannerAdListener bannerAdListener = BannerAdListener(
  //   onAdLoaded: (Ad ad) => debugPrint("Ad Loaded"),
  //   onAdFailedToLoad: (ad, error) {
  //     ad.dispose();
  //     debugPrint("Ad failed Load");
  //   },
  //   onAdOpened: (ad) => debugPrint("Ad Open"),
  // );

  @override
  void onInit() {
    getSubscriptionPlan();
    // razorpay.value = Razorpay();
    // bannerAd = BannerAd(
    //   size: AdSize.banner,
    //   adUnitId: Platform.isAndroid
    //       ? Constants.subscriptionBannerID
    //       : Constants.subscriptionBannerIosID,
    //   listener: bannerAdListener,
    //   request: const AdRequest(),
    // );
    // bannerAd.load();
    super.onInit();
  }

  void getSubscriptionPlan() async {
    UserRepository().getSubscriptionPlan().then((value) {
      value?.fold((l) {
        isLoading.value = false;
        Utils.showMessage(l);
      }, (r) {
        subscriptionList.value = r;
        subscriptionId.value = subscriptionList[0].id.toString();
        selectedSubscriptionPrice.value =
            int.parse(subscriptionList[0].planprice.toString()) ?? 0;
        planDescription.value = subscriptionList[0].msgcountstr ?? "";
        isLoading.value = false;
      });
    });
  }

  // void getSubscription() {
  //   Razorpay razorpay = Razorpay();
  //   var options = {
  //     //'key': 'rzp_test_1DP5mmOlF5G5ag',
  //     'key': 'rzp_live_4rgiE0qVGFMJDZJ9SsrRjNRccUpSiOfCnPlGmC',
  //     'amount': int.parse("${selectedSubscriptionPrice.value}00"),
  //     'name': 'INR.${selectedSubscriptionPrice.value}/year',
  //     'description':
  //         "Buy ${planDescription.value} Messages wished for your loved ones.",
  //     'retry': {'enabled': true, 'max_count': 1},
  //     'send_sms_hash': false,
  //     'external': {
  //       'wallets': ['paytm']
  //     }
  //   };
  //   razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
  //   razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
  //   razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  //   razorpay.open(options);
  // }
  //
  // void handlePaymentErrorResponse(PaymentFailureResponse response) {
  //   print("============Failled${response.message.toString()}");
  // }
  //
  // void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
  //   onCreatePayment(subscriptionId.value);
  // }
  //
  // void handleExternalWalletSelected(ExternalWalletResponse response) {}
  //
  // void onCreatePayment(String subscriptionId) async {
  //   Map<String, dynamic> params = {};
  //   params.putIfAbsent('subscriptionplanid', () => subscriptionId);
  //   params.putIfAbsent('paymentmethod', () => "Online");
  //   params.putIfAbsent('paymentstatus', () => true);
  //
  //   UserRepository().createPayment(params).then((value) {
  //     value?.fold((l) {
  //       Utils.showMessage(l);
  //     }, (r) {
  //       StorageManager().setUserSubscription(true);
  //       Utils.showMessage(r.statusMsg.toString());
  //       DashboardController dashboardController =
  //           Get.find<DashboardController>();
  //       HomeController homeController = Get.find<HomeController>();
  //       dashboardController.screenIndex.value = 0;
  //       homeController.tapIndex.value = 0;
  //       homeController.tabController!.animateTo(0);
  //       homeController.getSubscriptionCount();
  //     });
  //   });
  // }
}
