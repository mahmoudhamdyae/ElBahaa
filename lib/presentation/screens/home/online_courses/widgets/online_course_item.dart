import 'package:elbahaa/domain/models/online_courses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/constants_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../controller/online_courses_controller.dart';

class OnlineCourseItem extends StatelessWidget {

  final OnlineCourses onlineCourse;
  const OnlineCourseItem({super.key, required this.onlineCourse});

  void _cancelOrder() async {
    OnlineCoursesController controller = Get.find<OnlineCoursesController>();
    await controller.delOnlineCourse(onlineCourse.id ?? -1);
    if (controller.delStatus == RxStatus.success()) {
      controller.getOnlineCourses();
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: null,
          message: AppStrings.failDialogTitle,
          icon: Icon(Icons.error_outline, color: ColorManager.error,),
          duration: Duration(seconds: AppConstants.snackBarTime),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
