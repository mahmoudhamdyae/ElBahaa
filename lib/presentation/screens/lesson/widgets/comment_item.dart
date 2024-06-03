import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/lesson/lesson.dart';

class CommentItem extends StatelessWidget {

  final Comments comment;
  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            comment.user?.name ?? '',
            style: getLargeStyle(),
          ),
          const SizedBox(width: 16.0,),
          Text(
            comment.comment ?? '',
            style: getSmallStyle(),
          ),
        ],
      ),
    );
  }
}
