import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/screens/auth/login/widgets/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import '../controller/onboarding_controller.dart';
import '../controller/onboarding_model.dart';
import '../widgets/onboarding_dots.dart';
import '../widgets/onboarding_page_view.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Get.offAll(() => const LoginScreen()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 24.0),
                    child: Text(
                      AppStrings.onboardingSkip,
                      style: getLargeStyle(
                        fontSize: AppSize.s18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0,),
            const Expanded(
              child: OnboardingPageView(),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const SizedBox(height: 64.0,),
                  const OnboardingDots(),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
                    width: double.infinity,
                    child: GetBuilder<OnboardingController>(
                      builder: (OnboardingController controller) {
                        return FilledButton(
                          style: getFilledButtonStyle(),
                          onPressed: controller.next,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              controller.currentPage != OnboardingModel.getItems().length - 1 ? AppStrings.onboardingNext : AppStrings.onboardingStart,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
