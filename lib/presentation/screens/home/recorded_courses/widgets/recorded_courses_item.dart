import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../domain/models/courses/course.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../widgets/bookmark_course.dart';
import '../../../../widgets/buy_widget.dart';
import '../../../../widgets/price_widget.dart';
import '../../../course/widgets/course_screen.dart';
import '../../../lesson/widgets/lesson_screen.dart';

class RecordedCoursesItem extends StatelessWidget {

  final Course course;
  const RecordedCoursesItem({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CourseScreen(subject: course,));
      },
      child: Container(
        height: 130,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          border: Border.all(
            color: ColorManager.lightGrey,
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -12,
              right: -2,
              child: Image.asset(
                ImageAssets.course,
                height: 140,
                width: 110,
              ),
            ),
            Positioned(
              right: 125.0,
              top: 16.0,
              child: Column(
                  children: [
                    Text(
                      course.name,
                      style: getLargeStyle(
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    const SizedBox(height: 8.0,),
                    PriceWidget(price: course.month, month: AppStrings.monthly,),
                  ],
                ),
            ),
            Positioned(
              top: -8,
              left: -8,
              child: BookmarkCourse(course: course),
            ),
            Positioned(
              top: 16.0,
              left: 50.0,
                child: Column(
                  children: [
                    Text(
                      course.teacher,
                      style: getSmallStyle(
                        color: const Color(0xff808080),
                      ),
                    ),
                    const SizedBox(height: 8.0,),
                    PriceWidget(price: course.term, month: AppStrings.termly,),
                  ],
                ),
            ),
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   left: 0,
            //   child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           OutlinedButton(
            //               style: getOutlinedButtonStyle(),
            //               onPressed: () {
            //                 Get.to(const LessonScreen(), arguments: { 'course': course });
            //               },
            //               child: Text(
            //                 AppStrings.freeTry,
            //                 style: getSmallStyle(),
            //               )
            //           ),
            //           const SizedBox(width: 8.0,),
            //           BuyWidget(course: course, width: 120,),
            //         ],
            //       ),
            //     ),
            // )
          ],
        ),
      ),
    );
  }
}
