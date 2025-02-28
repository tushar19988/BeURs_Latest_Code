import 'dart:developer';
import 'dart:io';
import 'package:beurs/app/app_class.dart';
import 'package:beurs/app/app_route.dart';
import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/data/network/models/login_response.dart';
import 'package:beurs/data/network/models/social_media_response.dart';
import 'package:beurs/data/repository/user_repository.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/notification_permission_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginController extends GetxController {
  RxBool isPasswordInput = true.obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  RxString getFCMToken = "".obs;
  LoginResponse loginResponse = LoginResponse();

  SocialMedialLoginResponse socialMedialLoginResponse =
      SocialMedialLoginResponse();

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool isNotificationPermissionDenied = false;

  @override
  void onInit() {
    _checkNotificationPermission();
    super.onInit();
  }

  @override
  void onReady() {
    getFirebaseToken();
    super.onReady();
  }



  void _checkNotificationPermission() async {
    NotificationSettings settings =
        await _firebaseMessaging.getNotificationSettings();

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      isNotificationPermissionDenied = true;
      return;
    }

    if (settings.authorizationStatus != AuthorizationStatus.authorized &&
        !isNotificationPermissionDenied) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return NotificationPermissionDialog(
              onAccept: _requestNotificationPermission,
              onDecline: () {
                Navigator.of(context).pop();
                _handlePermissionDeclined();
              },
            );
          },
        );
      });
    } else {
      getFirebaseToken();
    }
  }

  void _requestNotificationPermission() async {
    Navigator.of(Get.context!).pop();
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      getFirebaseToken();
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      _handlePermissionDeclined();
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      getFirebaseToken();
    } else {
      debugPrint("Permission status: ${settings.authorizationStatus}");
    }
  }

  void _handlePermissionDeclined() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Notification Permission Denied"),
          content: const Text(
              "You have denied notification permissions. To receive important updates, please enable notifications in your app settings."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Dismiss"),
            ),
            ElevatedButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: const Text("Open Settings"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.value.clear();
    passwordController.value.clear();
    super.dispose();
  }

  void togglePassword() {
    isPasswordInput.value = !isPasswordInput.value;
  }

  void getFirebaseToken() {
    if (Platform.isAndroid) {
      FirebaseMessaging.instance.getToken().then((getTokenValue) {
        debugPrint("=======FCM:- $getTokenValue");
        getFCMToken.value = getTokenValue ?? "";
      });
    } else {
      FirebaseMessaging.instance.getAPNSToken().then((getAPNTokenValue) {
        debugPrint("=======FCM:- $getAPNTokenValue");
        getFCMToken.value = getAPNTokenValue ?? "";
      });
    }
  }

  bool checkSignInValidations() {
    if (emailController.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter your email address.");
      return false;
    } else if (!emailController.value.text.trim().isEmail) {
      Utils.showMessage("Please enter valid email address.");
      return false;
    } else if (passwordController.value.text.trim().isEmpty) {
      Utils.showMessage("Please enter your password.");
      return false;
    }
    return true;
  }

  // googleSign() async {
  //   AppClass().showLoading(true);
  //   try {
  //     var user = await _googleSignIn.signIn();
  //     debugPrint("Google Sign-In: $user");
  //   } catch (e) {
  //     debugPrint("Error during Google Sign-In: $e");
  //     AppClass().showLoading(false);
  //     Utils.showMessage("Something went wrong: $e");
  //   }
  // }


  Future<UserCredential?> signInWithFacebook() async {
    debugPrint("Checkpoint 1: Starting Facebook Sign-In");
    AppClass().showLoading(true);

    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status != LoginStatus.success) {
        // User canceled the sign-in process or an error occurred
        AppClass().showLoading(false);
        Utils.showMessage("Facebook Sign-In was canceled or failed");
        debugPrint("Checkpoint 2: Facebook Sign-In failed or canceled");
        return null;
      }

      debugPrint(
          "Checkpoint 2: Facebook User Signed In - ${loginResult.accessToken?.tokenString}");
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      debugPrint("Checkpoint 3: Authenticating with Firebase");
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      if (userCredential != null) {
        debugPrint("Checkpoint 4: Firebase Sign-In Successful");
        AppClass().showLoading(false);
        socialLogin(
          loginResult.accessToken!.tokenString,
          '1',
          userCredential.user?.photoURL ??
              "", // Facebook may not always provide a photo URL
          userCredential.user?.email ?? "",
          userCredential.user?.displayName ?? "",
        );
        return userCredential;
      } else {
        debugPrint("Checkpoint 5: Firebase UserCredential is null");
        AppClass().showLoading(false);
        Utils.showMessage("Failed to authenticate with Firebase");
      }
    } catch (e) {
      debugPrint("Error during Facebook Sign-In: $e");
      AppClass().showLoading(false);
      Utils.showMessage("Something went wrong: $e");
    }
    return null;
  }

  void onSignIn() async {
    getFirebaseToken();
    if (checkSignInValidations()) {
      Utils.closeKeyboard();
      var deviceId = await Utils.getDeviceId();
      debugPrint("Device Id $deviceId");
      Map<String, dynamic> params = {};
      params.putIfAbsent('emailid', () => emailController.value.text.trim());
      params.putIfAbsent(
          'password', () => passwordController.value.text.trim());
      params.putIfAbsent(
          'devicename', () => Platform.isAndroid ? "android" : "ios");
      params.putIfAbsent(
          'devicetype', () => Platform.isAndroid ? "android" : "ios");
      params.putIfAbsent('deviceid', () => deviceId.toString());
      params.putIfAbsent('devicetoken', () => getFCMToken.value ?? "");
      UserRepository().signIn(params).then((value) {
        value?.fold((l) {
          Utils.showMessage(l);
        }, (r) {
          loginResponse = r.data;
          StorageManager().setAuthToken(loginResponse.accessToken.toString());
          log("Token Value ${loginResponse.accessToken.toString()}");
          StorageManager().setEmail(loginResponse.emailid.toString());
          StorageManager().setName(loginResponse.username.toString());
          StorageManager().setUserImage(loginResponse.userimage.toString());
          StorageManager().setUserId(loginResponse.userid.toString());
          StorageManager()
              .setUserSubscription(loginResponse.isSubscription ?? false);
          //StorageManager().setDateOfBirth("${loginResponse.birthdate!.day.toString()}/${loginResponse.birthdate!.month.toString().padLeft(2,"0")}/${loginResponse.birthdate!.year.toString()}");
          Get.offAllNamed(AppRoutes.dashboardPage);
        });
      });
    }
  }

  void socialLogin(String socialId, String socialType, String userimage,
      String email, String name) async {
    Map<String, dynamic> params = {};
    FirebaseMessaging.instance.getToken().then((getTokenValue) async {
      var deviceId = await Utils.getDeviceId();
      debugPrint("Device Id $deviceId");
      params.putIfAbsent('social_id', () => socialId);
      params.putIfAbsent('social_type', () => socialType);
      params.putIfAbsent('username', () => name);
      params.putIfAbsent('userimage', () => userimage);
      params.putIfAbsent('deviceid', () => deviceId.toString());
      params.putIfAbsent(
          'devicename', () => Platform.isAndroid ? "Android" : "ios");
      params.putIfAbsent(
          'devicetype', () => Platform.isAndroid ? "Android" : "ios");
      params.putIfAbsent('devicetoken', () => getTokenValue);
      params.putIfAbsent('email', () => email);

      debugPrint("Social Signin:- $params");

      UserRepository().socialLogin(params).then((value) {
        value?.fold((l) {
          //Utils.showMessage(LocaleKeys.error.tr, l);
          AppClass().showLoading(false);
        }, (r) async {
          socialMedialLoginResponse = r;
          AppClass().showLoading(false);
          debugPrint("isProfile:- ${socialMedialLoginResponse.isProfile}");
          debugPrint("birthdate:- ${socialMedialLoginResponse.birthdate}");

          if (socialMedialLoginResponse.isProfile == true) {
            StorageManager()
                .setEmail(socialMedialLoginResponse.emailid.toString());
            StorageManager()
                .setName(socialMedialLoginResponse.username.toString());
            StorageManager()
                .setUserImage(socialMedialLoginResponse.userimage.toString());
            StorageManager().setUserId(socialMedialLoginResponse.id.toString());
            StorageManager().setUserSubscription(
                socialMedialLoginResponse.usersubscription ?? false);
            Get.offAllNamed(AppRoutes.dashboardPage);
          } else {
            Get.offAllNamed(AppRoutes.createProfilePage, arguments: {
              "token": socialMedialLoginResponse.accessToken.toString(),
              "email": socialMedialLoginResponse.emailid.toString(),
              "user_name": socialMedialLoginResponse.username.toString(),
              "user_image": userimage,
              "user_id": socialMedialLoginResponse.id.toString(),
              "user_subscription": socialMedialLoginResponse.usersubscription,
              "birthdate": socialMedialLoginResponse.birthdate != null
                  ? "${socialMedialLoginResponse.birthdate!.day}-${socialMedialLoginResponse.birthdate!.month}-${socialMedialLoginResponse.birthdate!.year}"
                  : "",
              "mobileNumber": socialMedialLoginResponse.mobileno
            });
          }
          StorageManager()
              .setAuthToken(socialMedialLoginResponse.accessToken.toString());
        });
      });
    });
  }
}
