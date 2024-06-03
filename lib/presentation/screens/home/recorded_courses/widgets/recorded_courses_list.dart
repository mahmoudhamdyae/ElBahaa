import 'package:elbahaa/core/utils/insets.dart';
import 'package:elbahaa/presentation/screens/home/recorded_courses/widgets/recorded_courses_item.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/courses/course.dart';

class RecordedCoursesList extends StatelessWidget {

  final List<Course> subjects;
  const RecordedCoursesList({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return isWide(context) ? _buildCoursesGrid(context) : _buildCoursesList();
  }

  ListView _buildCoursesList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          return RecordedCoursesItem(course: subjects[index],);
        },
      );
  }

  Widget _buildCoursesGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: (MediaQuery.of(context).size.width ~/ 320).toInt(),
      childAspectRatio: 2.8,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: List.generate(subjects.length, (index) {
        return RecordedCoursesItem(course: subjects[index],);
      }),
    );
  }
}
