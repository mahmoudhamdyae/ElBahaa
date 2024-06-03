import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../presentation/resources/constants_manager.dart';
import '../presentation/resources/strings_manager.dart';

Future<void> launchSite(String url) async {
  GetPlatform.isAndroid ? runOnAndroid(url) :
  runOnAndroid(url);
}

Future<void> runOnAndroid(String url) async  {
  Uri uri = Uri.parse(url);
  try {
    await launchUrl(uri);
  } catch (e) {
    debugPrint('Error launching URL: $e');
  }
}

Future<void> runOnIos() async {
  // Get.showSnackbar(
  //   const GetSnackBar(
  //     title: null,
  //     message: AppStrings.goToSite,
  //     duration: Duration(seconds: AppConstants.snackBarTime),
  //   ),
  // );
}