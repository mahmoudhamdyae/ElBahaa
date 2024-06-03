import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../domain/models/notes/note.dart';
import '../../../../../domain/models/package.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../controller/printed_notes_controller.dart';

class RemoveNoteFromCartButton extends StatelessWidget {

  final Note note;
  final int index;
  const RemoveNoteFromCartButton({super.key, required this.note, required this.index});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: getOutlinedButtonStyle(),
        onPressed: () {
          Get.find<PrintedNotesController>().removeNoteFromCart(note, index);
        },
        child: Text(
          AppStrings.removeFromCart,
          textAlign: TextAlign.center,
          style: getSmallStyle(
            color: ColorManager.secondary,
          ),
        ),
    );
  }
}

class RemovePackageFromCartButton extends StatelessWidget {

  final Package package;
  final int index;
  const RemovePackageFromCartButton({super.key, required this.package, required this.index});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: getOutlinedButtonStyle(),
      onPressed: () {
        Get.find<PrintedNotesController>().removePackageFromCart(package, false, index);
      },
      child: Text(
        AppStrings.removeFromCart,
        textAlign: TextAlign.center,
        style: getSmallStyle(
          color: ColorManager.secondary,
        ),
      ),
    );
  }
}
