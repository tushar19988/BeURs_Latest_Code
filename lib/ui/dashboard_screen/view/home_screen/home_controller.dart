import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/data/network/models/past_wishes_response.dart';
import 'package:beurs/data/network/models/subscription_count_response.dart';
import 'package:beurs/data/network/models/template_response.dart';
import 'package:beurs/data/network/models/upcoming_birthday_response.dart';
import 'package:beurs/data/repository/app_repository.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/ui/dashboard_screen/view/dashboard_controller.dart';
import 'package:beurs/utility/interstitial_ad.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart'; // Updated import

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt tapIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxBool isUpcomingLoading = true.obs;
  RxBool isPastWishesLoading = true.obs;
  RxBool isLoadingContact = true.obs;
  RxList<Map<String, dynamic>> contactList = <Map<String, dynamic>>[].obs;
  RxList<PastWishesResponse> pastWishesResponse = <PastWishesResponse>[].obs;
  RxList<UpcomingBirthdayResponse> upComingResponse =
      <UpcomingBirthdayResponse>[].obs;
  RxList<TemplateResponse> templateResponse = <TemplateResponse>[].obs;
  TabController? tabController;
  TextEditingController searchController = TextEditingController();
  DashboardController dashboardController = Get.find<DashboardController>();
  RxInt selectedMessage = 0.obs;
  RxString selectedMessageDescription = "".obs;
  RxList<Contact> contactData = <Contact>[].obs;
  RxString searchText = "".obs;
  SubscriptionCountResponse subscriptionCountResponse =
      SubscriptionCountResponse();
  RxString subScriptionCount = "".obs;
  RxString usersubscription = "true".obs;
  RxString subscriptionCountStatus = "true".obs;
  RxString subscriptionname = "Free Plan".obs;
  RxString displayName = "".obs;
  RxString profile = "".obs;
  RxString userName = "".obs;
  final InterstitialAdManager adManager = InterstitialAdManager();

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 3);
    askPermissions();
    getSubscriptionCount();
    getTemplate();
    getUserProfile();
    super.onInit();
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  void getUserProfile() async {
    profile.value = StorageManager().getUserImage().toString();
    userName.value = StorageManager().getName().toString();
  }

  getUpComingBirthday() async {
    UserRepository().getUpComingWishes().then((value) {
      value?.fold((l) {
        isUpcomingLoading.value = false;
      }, (r) {
        upComingResponse.clear();
        upComingResponse.addAll(r);
        isUpcomingLoading.value = false;
      });
    });
  }

  getPastWishes() async {
    UserRepository().getPastWishes().then((value) {
      value?.fold((l) {
        isPastWishesLoading.value = false;
      }, (r) {
        pastWishesResponse.clear();
        pastWishesResponse.addAll(r);
        isPastWishesLoading.value = false;
      });
    });
  }

  void getSubscriptionCount() async {
    UserRepository().getSubscriptionCount().then((value) {
      value?.fold((l) {
        isLoading.value = false;
        Utils.showMessage(l);
      }, (r) {
        isLoading.value = false;
        subscriptionCountResponse = r;
        subScriptionCount.value =
            subscriptionCountResponse.usersubscriptionCount ?? "";
        usersubscription.value =
            subscriptionCountResponse.usersubscription ?? "";
        subscriptionCountStatus.value =
            subscriptionCountResponse.subscriptionCountStatus ?? "";
        subscriptionname.value =
            subscriptionCountResponse.subscriptionname ?? "";
      });
    });
  }

  void getTemplate() async {
    UserRepository().getTemplate().then((value) {
      value?.fold((l) {}, (r) {
        templateResponse.value = r;
      });
    });
  }

  Future<void> askPermissions() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true);
      isLoadingContact.value = false;

      if (contacts.isNotEmpty) {
        contactData.value = contacts;
        for (var i = 0; i < contacts.length; i++) {
          String displayName = contacts[i].name.first;
          List<Phone> phones = contacts[i].phones;

          if (phones.isNotEmpty) {
            if (phones.last.number.length >= 9) {
              contactList.add({
                "Name": displayName.replaceAll(
                    RegExp('(\'|\"|\&|\<|\>|,|%|#|\$)'), ''),
                "ContactNo": phones.last.number
                    .replaceAll(RegExp(r'[-\s()\s+\s/\s,/s#/s./s*/s]'), '')
              });
            }
          }

          if (i == contacts.length - 1) {
            sendContacts(contactList);
          }
        }

        if (StorageManager().getInfoPopUp() != true) {
          await showDialog(
            context: Get.context as BuildContext,
            builder: (context) => AlertDialog(
              content: SizedBox(
                height: 150.h,
                child: Column(
                  children: [
                    CommonTextWidget(
                      text:
                          "Select Any Contact to send Birthday Message from the list.",
                      textSize: 15.sp,
                      textAlign: TextAlign.center,
                    ),
                    Expanded(child: Container()),
                    CommonAppButton(
                        borderRadius: 10.r,
                        text: "Ok",
                        onClick: () {
                          StorageManager().setInfoPopUp(true);
                          Get.back();
                        })
                  ],
                ),
              ),
            ),
          );
        }
      }
    } else {
      _handleInvalidPermissions(PermissionStatus.denied);
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      Utils.showMessage("Access to contact data denied");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      Utils.showMessage("Contact data not available on device");
    }
  }

  void sendMessageTemplate(String contactName, String contactNumber) {
    Map<String, dynamic> params = {};
    params.putIfAbsent('contactname', () => contactName.toString());
    params.putIfAbsent('contactno', () => contactNumber.toString());
    params.putIfAbsent(
        'birthdaymsg',
        () => selectedMessageDescription.value == " " ||
                selectedMessage.value == 0
            ? templateResponse.first.msgstr
            : selectedMessageDescription.value.toString());

    AppRepository().sendMessageTemplate(params).then((value) {
      value?.fold((l) {
        Utils.showMessage(l);
      }, (r) {
        Get.back();
        Utils.showMessage("Wish sent successfully.");
        getSubscriptionCount();
      });
    });
  }

  void sendContacts(List<Map<String, dynamic>> contacts) async {
    var deviceId = await Utils.getDeviceId();
    Map<String, dynamic> params = {};
    Map<String, dynamic> data = {
      "data": {"contactlist": contactList}
    };
    params.putIfAbsent('json_data', () => jsonEncode(data));
    params.putIfAbsent('deviceid', () => deviceId.toString());

    UserRepository().syncContact(params).then((value) {
      value?.fold((l) {
        Utils.showMessage(l);
      }, (r) {});
    });
  }

  String getContactSearchData(String value) {
    searchText.value = value;
    return value;
  }

  List<Contact> searchContactData({required List<Contact> contact}) {
    if (searchText.isNotEmpty) {
      contact = contact
          .where((element) => element.displayName
              .toString()
              .toLowerCase()
              .contains(searchText.value.toLowerCase()))
          .toList();
    }
    return contact;
  }
}
