import 'package:elbahaa/domain/models/online_courses.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: ColorManager.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // التاريخ
                  Row(
                    children: [
                      Text(
                        '${AppStrings.dateHint}: ',
                        style: getLargeStyle(),
                      ),
                      Text(
                        '${onlineCourse.date}',
                        style: getSmallStyle(),
                      ),
                    ],
                  ),
                  // الوقت
                  Row(
                    children: [
                      Text(
                        '${AppStrings.timeHint}: ',
                        style: getLargeStyle(),
                      ),
                      Text(
                        '${onlineCourse.time}',
                        style: getSmallStyle(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0,),
              // عدد الدقائق
              Row(
                children: [
                  Text(
                    '${AppStrings.minuteHint}: ',
                    style: getLargeStyle(),
                  ),
                  Text(
                    '${onlineCourse.minute}',
                    style: getSmallStyle(),
                  ),
                ],
              ),
              const SizedBox(height: 16.0,),
              // حالة الطلب
              Row(
                children: [
                  Text(
                    '${AppStrings.orderStatus}: ',
                    style: getLargeStyle(),
                  ),
                  Text(
                    '${onlineCourse.status}',
                    style: getSmallStyle(),
                  ),
                ],
              ),
              const SizedBox(height: 16.0,),
            ],
          ),
        ),
      ),
    );
  }
}
