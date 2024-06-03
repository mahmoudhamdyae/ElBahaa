import 'package:elbahaa/domain/models/courses/course.dart';
import 'package:flutter/material.dart';

class SubscriptionScreenBody extends StatelessWidget {

  final List<Course> courses;
  const SubscriptionScreenBody({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(courses[index].name),
            ),
          );
        }
    );
  }
}
