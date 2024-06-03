import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../core/download_note.dart';

class DownloadNoteButton extends StatelessWidget {

  final String pdf;
  const DownloadNoteButton({super.key, required this.pdf});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: getFilledButtonStyle(),
          onPressed: () {
            downloadNote(context, pdf, true);
          },
          child: Row(
            children: [
              Text(
                AppStrings.downloadNote,
                style: getSmallStyle(
                  color: ColorManager.white,
                ),
              ),
              const SizedBox(width: 16.0,),
              const Icon(
                Icons.download,
                size: 16,
              ),
            ],
          )),
    )
    ;
  }
}
