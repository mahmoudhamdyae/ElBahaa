import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/screens/lesson/widgets/lesson_number.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/lesson/wehda.dart';

class CourseLessonWidget extends StatelessWidget {

  final List<Wehda> wehdat;
  final bool isInLessonScreen;

  const CourseLessonWidget({super.key, required this.wehdat, required this.isInLessonScreen});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wehdat.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
              right: 16,
              left: 16,
            ),
          child: Row(
            children: [
              LessonNumber(lessonNo: index),
              const SizedBox(width: 16,),
              Text(wehdat[index].title),
              Expanded(child: Container()),
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 1,
                          color: ColorManager.primary
                      )
                  ),
                  child: const Icon(
                    Icons.bookmark_border,
                    color: ColorManager.primary,
                  ),
              ),
            ],
          ),
        );
      },
    );
  }
}
