import 'package:elbahaa/presentation/screens/auth/login/widgets/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'onboarding_model.dart';

class OnboardingController extends GetxController {

  int currentPage = 0;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void next() {
    currentPage++;

    if (currentPage > OnboardingModel.getItems().length - 1) {
      Get.offAll(() => const LoginScreen());
    } else {
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  onPageChanged(int index) {
    currentPage = index;
    update();
  }
}