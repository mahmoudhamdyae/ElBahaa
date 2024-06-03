import 'package:elbahaa/presentation/screens/auth/login/widgets/login_screen.dart';
import 'package:elbahaa/presentation/screens/home/widgets/home_app_bar/account_column.dart';
import 'package:elbahaa/presentation/screens/home/widgets/home_app_bar/user_image.dart';
import 'package:elbahaa/presentation/widgets/cart_app_bar_button.dart';
import 'package:elbahaa/presentation/widgets/notifications_app_bar_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth/auth_controller.dart';

class HomeAppBar extends StatelessWidget {

  final AuthController _controller = Get.find<AuthController>();
  HomeAppBar({super.key});

  void _login() {
    if (_controller.isUserLoggedIn()) {
      // Navigate to Profile
    } else {
      // Navigate to login screen
      Get.to(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 12.0,
          bottom: 12.0,
          right: 16.0,
          left: 16.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(onTap: _login, child: const UserImage()),
          const SizedBox(width: 8,),
          InkWell(onTap: _login, child: AccountColumn()),
          Expanded(child: Container()),
          // Cart Button
          const CartAppBarButton(),
          const SizedBox(width: 16.0,),
          // Notifications Button
          const NotificationsAppBarButton(),
        ],
      ),
    );
  }
}
