import 'package:elbahaa/presentation/screens/auth/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/styles_manager.dart';

class AccountColumn extends StatelessWidget {

  final AuthController _controller = Get.find<AuthController>();
  AccountColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _controller.isUserLoggedIn() ? AppStrings.welcomeBack : AppStrings.welcome,
          style: getSmallStyle(color: ColorManager.secondary),
        ),
        Text(
          _controller.isUserLoggedIn() ? _controller.getUserName() : AppStrings.pleaseLogin,
          style: getLargeStyle(),
        ),
      ],
    );
  }
}
