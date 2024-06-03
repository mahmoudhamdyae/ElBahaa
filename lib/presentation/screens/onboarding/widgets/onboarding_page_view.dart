import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controller/onboarding_controller.dart';
import '../controller/onboarding_model.dart';
import 'onboarding_item.dart';

class OnboardingPageView extends GetView<OnboardingController> {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (int index) {
        controller.onPageChanged(index);
      },
      itemCount: OnboardingModel.getItems().length,
      itemBuilder: (BuildContext context, int index) {
        return OnboardingItem(onBoardingModel: OnboardingModel.getItems()[index]);
      },
    );
  }
}
