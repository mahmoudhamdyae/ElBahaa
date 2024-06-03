import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/resources/values_manager.dart';
import 'package:elbahaa/presentation/widgets/dialogs/choose_saff_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showChooseMarhalaDialog(
    BuildContext context,
    bool isCourses,
    Function(String, String) onTap,
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
              // المرحلة الابتدائية
              isCourses ? Container() : InkWell(
                onTap: () {
                  Get.back();
                  showChooseSaffDialog(context, AppStrings.primaryMarhala, (saff) =>
                      onTap(AppStrings.primaryMarhala, saff));
                },
                  child: ListTile(
                      title: Text(
                        AppStrings.primaryMarhala,
                        style: getSmallStyle(),
                      )
                  )
              ),
              // المرحلة المتوسطة
              InkWell(
                  onTap: () {
                    // Navigator.of(context).pop();
                    Get.back();
                    showChooseSaffDialog(context, AppStrings.mediumMarhala, (saff) =>
                        onTap(AppStrings.mediumMarhala, saff));
                  },
                  child: ListTile(
                      title: Text(
                        AppStrings.mediumMarhala,
                        style: getSmallStyle(),
                      )
                  )
              ),
              // المرحلة الثانوية
              InkWell(
                  onTap: () {
                    // Navigator.of(context).pop();
                    Get.back();
                    showChooseSaffDialog(context, AppStrings.secondaryMarhala, (saff) =>
                        onTap(AppStrings.secondaryMarhala, saff));
                  },
                  child: ListTile(
                      title: Text(
                        AppStrings.secondaryMarhala,
                        style: getSmallStyle(),
                      )
                  )
              ),
              // القدرات
              // InkWell(
              //     onTap: () {
              //       // Navigator.of(context).pop();
              //       Get.back();
              //       onTap(AppStrings.qodoratMarhala, '');
              //     },
              //     child: ListTile(
              //         title: Text(
              //           AppStrings.qodoratMarhala,
              //           style: getSmallStyle(),)
              //     )
              // ),
            ],
          ),
        );
      }
  );
}