import 'package:elbahaa/presentation/screens/home/online_courses/controller/online_courses_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/constants_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../../widgets/dialogs/error_dialog.dart';
import '../../../../widgets/dialogs/loading_dialog.dart';

class OrderOnlineCourseDialog extends StatefulWidget {
  const OrderOnlineCourseDialog({super.key});

  @override
  State<OrderOnlineCourseDialog> createState() => _OrderOnlineCourseDialogState();
}

class _OrderOnlineCourseDialogState extends State<OrderOnlineCourseDialog> {

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  _orderOnlineCourse() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      final OnlineCoursesController controller = Get.find<OnlineCoursesController>();

      showLoading(context);
      await controller.orderOnlineCourse().then((value) {
        showLoading(context);
        if (controller.postStatus.isError) {
          Get.back();
          showError(context, controller.postStatus.errorMessage.toString(), () {});
        } else {
          Get.back();
          Get.find<OnlineCoursesController>().getOnlineCourses();
          Get.showSnackbar(
            const GetSnackBar(
              title: null,
              message: AppStrings.successDialogTitle,
              icon: Icon(Icons.download_done, color: ColorManager.white,),
              duration: Duration(seconds: AppConstants.snackBarTime),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formState,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0,),
              // Date Edit Text // todo
              TextFormField(
                controller: Get.find<OnlineCoursesController>().date,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return AppStrings.dateInvalid;
                  }
                  return null;
                },
                style: getLargeStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.grey,
                ),
                decoration: getTextFieldDecoration(
                  hint: AppStrings.dateHint,
                  prefixIcon: null,
                  onPressed: () { },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              // Time Edit Text
              TextFormField(
                controller: Get.find<OnlineCoursesController>().time,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val.toString().isNotEmpty) {
                    return null;
                  }
                  return AppStrings.timeInvalid;
                },
                style: getLargeStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.grey,
                ),
                decoration: getTextFieldDecoration(
                  hint: AppStrings.timeHint,
                  prefixIcon: null,
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              // Minute Edit Text
              TextFormField(
                controller: Get.find<OnlineCoursesController>().minute,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val.toString().isNotEmpty) {
                    return null;
                  }
                  return AppStrings.minuteInvalid;
                },
                style: getLargeStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.grey,
                ),
                decoration: getTextFieldDecoration(
                  hint: AppStrings.minuteHint,
                  prefixIcon: null,
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              // Desc Edit Text
              TextFormField(
                controller: Get.find<OnlineCoursesController>().desc,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.toString().isNotEmpty) {
                    return null;
                  }
                  return AppStrings.descInvalid;
                },
                style: getLargeStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.grey,
                ),
                decoration: getTextFieldDecoration(
                  hint: AppStrings.descHint,
                  prefixIcon: null,
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              // Confirm Order Button
              SizedBox(
                width: double.infinity,
                height: AppSize.s40,
                child: FilledButton(
                  style: getFilledButtonStyle(),
                  onPressed: () async {
                    await _orderOnlineCourse();
                  },
                  child: const Text(
                    AppStrings.orderButton,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
