import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/constants_manager.dart';
import '../controller/online_courses_controller.dart';

showCancelOrderDialog(BuildContext context, int onlineCourseId) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          AppStrings.cancelOrderDialogTitle,
          style: getLargeStyle(),
        ),
        content: Text(
          AppStrings.cancelOrderDialogText,
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
            onPressed: () { _cancelOrder(context, onlineCourseId); },
            child: Text(
              AppStrings.cancelOrderOk,
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

void _cancelOrder(BuildContext context, int onlineCourseId) async {
  OnlineCoursesController controller = Get.find<OnlineCoursesController>();
  showLoading(context);
  await controller.delOnlineCourse(onlineCourseId);
  if (controller.delStatus.isSuccess) {
    controller.getOnlineCourses();
    Get.back();
    Get.back();
  } else {
    Get.back();
    Get.back();
    String? error = controller.delStatus.errorMessage;
    Get.showSnackbar(
      GetSnackBar(
        title: null,
        message: error ?? AppStrings.failDialogTitle,
        icon: const Icon(Icons.error_outline, color: ColorManager.error,),
        duration: const Duration(seconds: AppConstants.snackBarTime),
      ),
    );
  }
}