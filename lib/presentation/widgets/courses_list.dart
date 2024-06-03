import 'package:elbahaa/core/utils/insets.dart';
import 'package:elbahaa/presentation/screens/course/widgets/course_screen.dart';
import 'package:elbahaa/presentation/widgets/rate_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/models/courses/course.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import 'bookmark_course.dart';
import 'buy_widget.dart';

class CoursesList extends StatelessWidget {
  final List<Course> courses;

  const CoursesList({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return isWide(context) ? _buildCoursesGrid(context) : _buildCoursesList();
  }

  ListView _buildCoursesList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: courses.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildCourseItem(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 16.0,
        );
      },
    );
  }

  Widget _buildCoursesGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: (MediaQuery.of(context).size.width ~/ 300).toInt(),
      childAspectRatio: 2.2,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: List.generate(courses.length, (index) {
        return _buildCourseItem(index);
      }),
    );
  }

  InkWell _buildCourseItem(int index) {
    return InkWell(
      onTap: () {
        Get.to(() => CourseScreen(subject: courses[index]));
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffF2F2F2),
                width: 1,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.course,
                  height: 88,
                  width: 86,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(
                  width: 14.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courses[index].name,
                      style: getLargeStyle(
                          fontSize: FontSize.s14,
                          color: ColorManager.secondary),
                    ),
                    Text(
                      courses[index].teacher,
                      style: getSmallStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    RateWidget(rate: courses[index].rate),
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Positioned(left: 0, child: BookmarkCourse(course: courses[index])),
          // Positioned(
          //     bottom: 8,
          //     left: 12,
          //     child: BuyWidget(
          //       course: courses[index],
          //       width: 115,
          //     )),
        ],
      ),
    );
  }
}
