import 'dart:convert';
import 'dart:io';
import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/generated/locales.g.dart';
import 'package:beurs/widgets/common_progress_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'app/app_class.dart';
import 'app/app_colors.dart';
import 'app/app_route.dart';
import 'app/app_theme.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    enableVibration: true,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> getfirebasedata(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null && !kIsWeb) {
    final ByteData bytes =
        await rootBundle.load('assets/images/ic_app_logo_black.png');
    final Uint8List imageBytes = bytes.buffer.asUint8List();

    String action = jsonEncode(message.data);
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          priority: Priority.high,
          importance: Importance.max,
          setAsGroupSummary: true,
          styleInformation: const DefaultStyleInformation(true, true),
          icon: '@mipmap/ic_launcher',
          largeIcon: ByteArrayAndroidBitmap(imageBytes),
          autoCancel: true,
        ),
      ),
      payload: action,
    );
  }
}

// Future<PermissionStatus> _getContactPermission() async {
//   PermissionStatus permission = await Permission.contacts.status;
//   if (permission != PermissionStatus.granted &&
//       permission != PermissionStatus.permanentlyDenied) {
//     PermissionStatus permissionStatus = await Permission.contacts.request();
//     return permissionStatus;
//   } else {
//     return permission;
//   }
// }

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve the splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Mobile Ads
  MobileAds.instance.initialize();

  // Initialize Flutter Local Notifications
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Request Firebase Messaging permissions
  FirebaseMessaging.instance.requestPermission();
  // await _getContactPermission();

  // Set foreground notification presentation options
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    sound: true,
  );

  // Setup Firebase Messaging listeners
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    getfirebasedata(message);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Get FCM token

  if (Platform.isAndroid) {
    FirebaseMessaging.instance.getToken().then((getTokenValue) {
      debugPrint("=======FCM:- $getTokenValue");
    });
  } else {
    FirebaseMessaging.instance.getAPNSToken().then((token) {
      debugPrint('=======FCM APNS Token: $token');
    });
  }

  // Initialize GetStorage
  await GetStorage.init();

  // Register AppColors with GetX
  Get.put(AppColors());

  // Retrieve stored token and navigation state
  String? token = StorageManager().getEmail();
  bool? fromFresh = StorageManager().getFromFresh();

  // Determine initial route based on stored values
  runApp(MyApp(
      initialRoute: Platform.isIOS
          ? fromFresh == null
              ? AppRoutes.walkThroughPage
              : token == null
                  ? AppRoutes.signUpPage
                  : AppRoutes.dashboardPage
          : AppRoutes.initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppTheme.designSize,
      builder: (_, widget) => GetMaterialApp(
        enableLog: true,
        title: 'BeUrs',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.to.primaryColor,
          fontFamily: "helvetica",
          // Other theme properties
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        builder: (context, widget) => getMainAppViewBuilder(context, widget),
        getPages: AppRoutes.pages,
        initialRoute: initialRoute,
        translationsKeys: AppTranslation.translations,
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en'),
      ),
    );
  }

  /// Create main app view builder
  Widget getMainAppViewBuilder(BuildContext context, Widget? widget) {
    return Obx(() {
      return IgnorePointer(
        ignoring: AppClass().isShowLoading.isTrue,
        child: Stack(
          children: [
            widget ?? const Offstage(),
            if (AppClass().isShowLoading.isTrue)
              // Top level loading (used while API calls)
              ColoredBox(
                color: Colors.grey.withOpacity(0.5),
                child: const Center(
                  child: CommonProgressIndicator(),
                ),
              ),
          ],
        ),
      );
    });
  }
}
