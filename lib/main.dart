import 'package:elbahaa/core/get_x_di.dart';
import 'package:elbahaa/domain/models/courses/course.dart';
import 'package:elbahaa/presentation/rate_app_init_widget.dart';
import 'package:elbahaa/presentation/resources/theme_manager.dart';
import 'package:elbahaa/presentation/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'core/local_notification_service.dart';
import 'firebase_options.dart';

final _configuration = PurchasesConfiguration('appl_koNOphpUsRPZXqWCsbemfLTSqMI');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CourseAdapter());
  await GetXDi().dependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (GetPlatform.isIOS) {
    await Purchases.configure(_configuration);
  }
  await LocalNotificationService().init();
  requestPermissions();
  _listenForForegroundFCM();
  _listenForBackgroundFCM();
  _onMessageOpened();
  _getOnMessageOpenedTerminated();

  FirebaseMessaging.instance.getToken().then((token) =>
      debugPrint('Token: ${token.toString()}')
  );
  runApp(const MyApp());
}

Future<void> updateCustomerStatus() async  {
  final customerInfo = await Purchases.getCustomerInfo();
  final entitlement = customerInfo.entitlements.all['all_purchases'];
  debugPrint('============ ent $entitlement');
  if (entitlement != null && entitlement.isActive) {
    // Get.find<Repository>().pay();
    debugPrint('============ ent $entitlement');
  }
}

void requestPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint('User GrantedPermissions');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    debugPrint('User granted Provisional Permissions');
  } else {
    debugPrint('User declined or has not accepted permission');
  }
}

void _listenForForegroundFCM() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Message Foreground: ${message.notification?.title}');
    debugPrint('Message Foreground: ${message.notification?.body}');
    LocalNotificationService().showNotification(
      message.notification?.title ?? '',
      message.notification?.body ?? '',
    );
  });
}

void _listenForBackgroundFCM() async {
  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    debugPrint('Message Background: ${message.notification?.title}');
    debugPrint('Message Background: ${message.notification?.body}');
  });
}

void _onMessageOpened() {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('Message Opened: ${message.notification?.title}');
  });
}

void _getOnMessageOpenedTerminated() async {
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  debugPrint('Message Opened: ${initialMessage?.notification?.title}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      home: RateAppInitWidget(
          builder: (RateMyApp rateMyApp ) {
            return SplashScreen(rateMyApp: rateMyApp,);
          },
      ),
      initialBinding: GetXDi(),
    );
  }
}
