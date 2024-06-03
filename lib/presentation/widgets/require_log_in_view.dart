import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/resources/values_manager.dart';
import 'package:elbahaa/presentation/screens/auth/login/widgets/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequireLogInView extends StatelessWidget {
  const RequireLogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.requireLogIn,
          style: getLargeStyle(),
        ),
        const SizedBox(height: AppSize.s8,),
        OutlinedButton(
          style: getOutlinedButtonStyle(),
            onPressed: () => Get.to(() => const LoginScreen()),
            child: Text(
              AppStrings.requireLogInButton,
              style: getSmallStyle(),
            )
        )
      ],
    );
  }
}
