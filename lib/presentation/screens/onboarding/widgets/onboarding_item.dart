import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/onboarding_controller.dart';
import '../controller/onboarding_model.dart';

class OnboardingItem extends StatelessWidget {

  final OnboardingModel onBoardingModel;
  const OnboardingItem({super.key, required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  onBoardingModel.image!,
                  fit: BoxFit.fitHeight,
                ),
          )),
          const SizedBox(height: 16.0),
          Text(
            onBoardingModel.title!,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32.0),
        ],
      ),
    );
  }
}
