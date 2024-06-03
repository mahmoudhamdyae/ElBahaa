import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/printed_notes_controller.dart';

class AddToCartButton extends StatelessWidget {

  final String noteId;
  const AddToCartButton({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: getOutlinedButtonStyle(),
        onPressed: () {
          Get.find<PrintedNotesController>().addNoteToCart(noteId);
        },
        child: Text(
          AppStrings.addToCart,
          style: getSmallStyle(),
        )
    );
  }
}

class AddPackageToCartButton extends StatelessWidget {

  final String packageId;
  const AddPackageToCartButton({super.key, required this.packageId});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: getOutlinedButtonStyle(),
        onPressed: () {
          Get.find<PrintedNotesController>().addPackageToCart(packageId);
        },
        child: Text(
          AppStrings.addToCart,
          style: getSmallStyle(),
        )
    );
  }
}
