import 'package:elbahaa/core/utils/insets.dart';
import 'package:elbahaa/domain/models/courses/course.dart';
import 'package:elbahaa/domain/models/subscription_response.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/screens/lesson/widgets/lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class SubscriptionCoursesList extends StatelessWidget {
  final List<UserCourses> courses;

  const SubscriptionCoursesList({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return isWide(context) ? _buildCourseGrid(context) : _buildCourseList();
  }

  ListView _buildCourseList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: courses.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildCoursesItem(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 16.0,
        );
      },
    );
  }

  Widget _buildCourseGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount:(MediaQuery.of(context).size.width ~/ 300).toInt(),
      childAspectRatio: 3.5,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: List.generate(courses.length, (index) {
        return _buildCoursesItem(index);
      }),
    );
  }

  Widget _buildCoursesItem(int index) {
    return InkWell(
      onTap: () {
        UserCourses userCourses = courses[index];
        Course course = Course(
            userCourses.id ?? -1,
            userCourses.subjectName ?? '',
            userCourses.monthlySubscriptionPrice ?? 0,
            userCourses.termPrice ?? 0,
            userCourses.classroom ?? '',
            userCourses.type ?? '',
            userCourses.teacherRatioCourse.toString(),
            userCourses.techer?.name ?? '',
            userCourses.techer?.id ?? -1,
            userCourses.techer?.image ?? '',
            0
        );
        Get.to(() => const LessonScreen(), arguments: {'course': course});
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffF2F2F2),
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ImageAssets.course,
                height: 88,
                width: 86,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(
                width: 12.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courses[index].subjectName ?? '',
                    style: getLargeStyle(color: ColorManager.secondary),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    courses[index].techer?.name ?? '',
                    style: getSmallStyle(),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Text(
                '${AppStrings.expireDate}\n ${courses[index].expiryDate}',
                style: getSmallStyle(
                  color: ColorManager.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
