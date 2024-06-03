import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSoonDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: Text(
          AppStrings.soonDialogTitle,
          style: getLargeStyle(
            fontWeight: FontWeight.w400
          ),
        ),
        actions: [
          FilledButton(
            style: getFilledButtonStyle(),
            onPressed: () => Get.back(),
            child: Text(
              AppStrings.soonDialogAction,
              style: getSmallStyle(
                  color: ColorManager.white,
              ),
            ),
          )
        ],
      );
    },
  );
}