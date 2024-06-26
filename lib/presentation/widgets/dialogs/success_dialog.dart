import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/assets_manager.dart';

showSuccess(BuildContext context, String message) {
  return showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      // The shape of the dialog
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s20)),
      ),
      // The title of the dialog
      title: const Text(AppStrings.successDialogTitle),
      // The content of the dialog
      content: Column(
        children: [
          // Success Image
          SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset(JsonAssets.done)
          ),
          // Message Text
          Text(message),
          // Ok Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(AppStrings.successDialogAction)
              ),
            ],
          )
        ],
      ),
    );
  });
}