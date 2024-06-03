import 'dart:async';

import 'package:elbahaa/domain/repository/repository.dart';
import 'package:elbahaa/presentation/screens/auth/login/widgets/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_app/rate_my_app.dart';
import '../../resources/color_manager.dart';
import '../auth/auth_controller.dart';
import '../main_screen.dart';
import '../onboarding/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {

  final RateMyApp rateMyApp;
  const SplashScreen({Key? key, required this.rateMyApp}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  final Repository appPreferences = Get.find<Repository>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: 0), () =>
        _goNext()
    );
  }

  _goNext() async {
    appPreferences.isFirstTime().then((isFirstTime) {
      if (isFirstTime) {
        Get.offAll(() => const OnboardingScreen());
      } else if (appPreferences.isUserLoggedIn()) {
        // Navigate to main screen
        AuthController controller = Get.find<AuthController>();
        Get.offAll(() => MainScreen(
          selectedIndex: controller.isSubscribedAtOneSubjectAtLeast() ? 1 : 0,
          rateMyApp: widget.rateMyApp,
        ));
      } else {
        // Navigate to login screen
        Get.offAll(LoginScreen(rateMyApp: widget.rateMyApp,));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container()
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
