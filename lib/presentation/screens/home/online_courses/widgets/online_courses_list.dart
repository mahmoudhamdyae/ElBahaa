import 'package:elbahaa/presentation/screens/home/online_courses/widgets/online_course_item.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/online_courses.dart';

class OnlineCoursesList extends StatelessWidget {

  final List<OnlineCourses> onlineCourses;
  const OnlineCoursesList({super.key, required this.onlineCourses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: onlineCourses.length,
      itemBuilder: (BuildContext context, int index) {
        return OnlineCourseItem(onlineCourse: onlineCourses[index]);
      },
    );
  }
}
