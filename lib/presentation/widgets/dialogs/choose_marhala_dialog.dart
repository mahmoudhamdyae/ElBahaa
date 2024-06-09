import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/resources/values_manager.dart';
import 'package:elbahaa/presentation/widgets/dialogs/choose_saff_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showChooseMarhalaDialog(
    BuildContext context,
    bool isCourses,
    Function(String) onTap,
    ) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // The shape of the dialog
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          // The content of the dialog
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.pleaseChooseMarhala,
                style: getLargeStyle(),
              ),
              const SizedBox(
                height: AppSize.s16,
              ),
              // المرحلة الثانوية
              InkWell(
                  onTap: () {
                    Get.back();
                    onTap(AppStrings.secondaryMarhala);
                    // showChooseSaffDialog(context, AppStrings.secondaryMarhala, (saff) =>
                    //     onTap(AppStrings.secondaryMarhala, saff));
                  },
                  child: ListTile(
                      title: Text(
                        AppStrings.secondaryMarhala,
                        style: getSmallStyle(),
                      )
                  )
              ),
              // المرحلة الجامعية
              InkWell(
                  onTap: () {
                    // Navigator.of(context).pop();
                    Get.back();
                    onTap(AppStrings.universityMarhala);
                    // showChooseSaffDialog(context, AppStrings.universityMarhala, (saff) =>
                    //     onTap(AppStrings.universityMarhala, saff));
                  },
                  child: ListTile(
                      title: Text(
                        AppStrings.universityMarhala,
                        style: getSmallStyle(),
                      )
                  )
              ),
            ],
          ),
        );
      }
  );
}