import 'package:elbahaa/presentation/screens/home/printed_notes/controller/printed_notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/color_manager.dart';
import '../screens/cart/widgets/cart_screen.dart';

import 'package:badges/badges.dart' as badges;

class CartAppBarButton extends StatelessWidget {
  const CartAppBarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      onTap: () {
        Get.find<PrintedNotesController>().getAllNotes();
        Get.to(() => const CartScreen());
        },
      badgeStyle: const badges.BadgeStyle(badgeColor: ColorManager.primary),
      position: badges.BadgePosition.bottomEnd(bottom: 12, end: 20),
      badgeContent: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: GetX<PrintedNotesController>(
          init: Get.find<PrintedNotesController>(),
          builder: (PrintedNotesController controller) {
            return Text(
              controller.cartNumber.toString(),
              style: const TextStyle(
                color: ColorManager.white,
              ),
            );
          },
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
            Get.find<PrintedNotesController>().getAllNotes();
            Get.to(() => const CartScreen());
            },
          icon: const Icon(
            Icons.shopping_cart,
            size: 15,
            color: ColorManager.secondary,
          ),
        ),
      ),
    );
  }
}
