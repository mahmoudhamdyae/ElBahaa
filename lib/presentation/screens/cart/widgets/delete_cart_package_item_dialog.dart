import 'package:elbahaa/domain/models/package.dart';
import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/printed_notes/controller/printed_notes_controller.dart';

showDeleteCartPackageItemDialog(BuildContext context, Package package, int index) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          AppStrings.deleteCartDialogTitle,
          style: getLargeStyle(),
        ),
        content: Text(
          AppStrings.deleteCartDialogText,
          style: getSmallStyle(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
                AppStrings.cancel,
                style: getSmallStyle()),
          ),
          FilledButton(
            style: getFilledButtonStyle(),
            onPressed: () => _deleteNote(package, index),
            child: Text(
              AppStrings.deleteCartOk,
              style: getSmallStyle(
                  color: ColorManager.white
              ),
            ),
          )
        ],
      );
    },
  );
}

_deleteNote(Package package, int index) {
  Get.find<PrintedNotesController>().removePackageFromCart(package, true, index);
  Get.back();
}