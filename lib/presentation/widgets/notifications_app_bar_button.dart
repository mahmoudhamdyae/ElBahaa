import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/color_manager.dart';
import '../screens/notifications/widgets/notifications_screen.dart';

class NotificationsAppBarButton extends StatelessWidget {
  const NotificationsAppBarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      onTap: () {
        Get.to(() => NotificationsScreen());
      },
      badgeStyle: const badges.BadgeStyle(badgeColor: ColorManager.primary),
      position: badges.BadgePosition.bottomEnd(bottom: 12, end: 20),
      badgeContent: const Padding(
        padding: EdgeInsets.only(top: 1.0),
        child: Text(
          '0',
          style: TextStyle(
            color: ColorManager.white,
          ),
        ),
      ),
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: ColorManager.secondary)
        ),
        child: IconButton(
          onPressed: () {
            Get.to(() => NotificationsScreen());
          },
          icon: const Icon(
            Icons.notifications,
            size: 15,
            color: ColorManager.secondary,
          ),
        ),
      ),
    );
  }
}
