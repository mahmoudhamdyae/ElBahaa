import 'package:elbahaa/core/download_note.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';

class ExamItem extends StatelessWidget {

  final String text;
  final String link;
  const ExamItem({super.key, required this.text, required this.link});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => downloadExam(context, link),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            border: Border.all(
              color: ColorManager.lightGrey,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: getSmallStyle(),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.green,
                ),
                child: Text(
                  AppStrings.download,
                  style: getSmallStyle(
                    color: ColorManager.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
