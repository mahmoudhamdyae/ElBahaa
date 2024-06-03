import 'package:elbahaa/presentation/resources/strings_manager.dart';

import '../../../resources/assets_manager.dart';

class OnboardingModel {
  final String? title;
  final String? image;

  OnboardingModel._({
    this.title,
    this.image,
  });

  static List<OnboardingModel> getItems() {
    return [
      OnboardingModel._(
        title: AppStrings.onboarding1,
        image: ImageAssets.onboarding1,
      ),
      OnboardingModel._(
          title: AppStrings.onboarding2,
          image: ImageAssets.onboarding2
      ),
      OnboardingModel._(
          title: AppStrings.onboarding3,
          image: ImageAssets.onboarding3,
      ),
    ];
  }
}