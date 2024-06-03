import 'package:elbahaa/presentation/screens/home/printed_notes/widgets/cart_button.dart';
import 'package:elbahaa/presentation/screens/home/printed_notes/widgets/download_note_button.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/notes/note.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/styles_manager.dart';

class NoteItem extends StatelessWidget {

  final Note note;
  final int index;
  const NoteItem({super.key, required this.note, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(
          color: ColorManager.lightGrey,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            ImageAssets.books,
            height: 100,
            width: 225,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  note.name ?? '',
                  style: getLargeStyle(
                      fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  '${note.bookPrice} د.ك',
                  style: getLargeStyle(
                      fontSize: FontSize.s20,
                      color: ColorManager.secondary
                  ),
                )
              ],
            ),
          ),
          DownloadNoteButton(pdf: note.pdf ?? '',),
          CartButtonNote(note: note, index: index),
        ],
      ),
    );
  }
}
