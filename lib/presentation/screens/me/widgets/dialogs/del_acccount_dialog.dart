import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/constants_manager.dart';
import '../../../../widgets/dialogs/error_dialog.dart';
import '../../../../widgets/dialogs/loading_dialog.dart';
import '../../../auth/login/widgets/login_screen.dart';
import '../../controller/me_controller.dart';

showDelAccountDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          AppStrings.delAccountDialogTitle,
          style: getLargeStyle(),
        ),
        content: Text(
          AppStrings.delAccountDialogText,
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
            onPressed: () => _delAccount(context),
            child: Text(
              AppStrings.delAccountOk,
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

_delAccount(BuildContext context) async {
  Get.back();
  showLoading(context);
  final MeController controller = Get.find<MeController>();
  controller.delAccount().then((value) {
    if (controller.status.isError) {
      Get.back();
      showError(context, controller.status.errorMessage.toString(), () {});
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: null,
          message: AppStrings.delAccountSuccess,
          duration: Duration(seconds: AppConstants.snackBarTime),
        ),
      );
      Get.offAll(() => const LoginScreen());
    }
  });
}