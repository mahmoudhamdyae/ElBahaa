import 'package:elbahaa/core/purchases.dart';
import 'package:elbahaa/domain/models/courses/course.dart';
import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

showRequireAuthDialog(BuildContext context, Course course) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s20)),
          ),
          // The content of the dialog
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.pleaseSubscribe,
                style: getLargeStyle(),
              ),
              const SizedBox(height: AppSize.s16,),
              Row(
                children: [
                  OutlinedButton(
                    style: getOutlinedButtonStyle(),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppStrings.cancel,
                        style: getSmallStyle(),
                      )
                  ),
                  TextButton(
                      onPressed: () {
                        Get.back();
                        purchase(context, course, true);
                      },
                      child: Text(
                        AppStrings.subscribeMonth,
                        style: getSmallStyle(
                          color: ColorManager.secondary
                        ),
                      )
                  ),
                  const SizedBox(width: 4.0,),
                  TextButton(
                      onPressed: () {
                        Get.back();
                        purchase(context, course, false);
                      },
                      child: Text(
                        AppStrings.subscribeTerm,
                        style: getSmallStyle(
                            color: ColorManager.secondary
                        ),
                      )
                  ),
                ],
              )
            ],
          ),
        );
      }
  );
}