import 'package:flutter/cupertino.dart';

class LessonNumber extends StatelessWidget {
  final int lessonNo;
  const LessonNumber({super.key, required this.lessonNo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1,
          color: const Color(0xff2B7CB3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(lessonNo.toString()),
      ),
    );
  }
}
