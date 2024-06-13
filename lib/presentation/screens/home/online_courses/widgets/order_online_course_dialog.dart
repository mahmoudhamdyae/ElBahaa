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

  final String? restorationId;
  const OrderOnlineCourseDialog({super.key, this.restorationId});

  @override
  State<OrderOnlineCourseDialog> createState() => _OrderOnlineCourseDialogState();
}

class _OrderOnlineCourseDialogState extends State<OrderOnlineCourseDialog>
    with RestorationMixin {

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
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 2),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        Get.find<OnlineCoursesController>().date.text = '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      });
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime);

    if (pickedTime != null && pickedTime != selectedTime ) {
      setState(() {
        selectedTime = pickedTime;
        Get.find<OnlineCoursesController>().time.text = '${selectedTime.hour}:${selectedTime.minute}';
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
              // Date Edit Text
              TextFormField(
                controller: Get.find<OnlineCoursesController>().date,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.datetime,
                onTap: () {
                  _restorableDatePickerRouteFuture.present();
                },
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
                keyboardType: TextInputType.text,
                onTap: () => _selectTime(context),
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
                keyboardType: TextInputType.multiline,
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
