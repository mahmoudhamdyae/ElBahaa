import 'package:elbahaa/presentation/resources/assets_manager.dart';
import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/download_note.dart';


class TabMorfaqat extends StatefulWidget {

  final String? link;
  const TabMorfaqat({super.key, required this.link});

  @override
  State<TabMorfaqat> createState() => _TabMorfaqatState();
}

class _TabMorfaqatState extends State<TabMorfaqat> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.notesTab,
              style: getSmallStyle(
                color: widget.link == '' || widget.link == null ? ColorManager.grey : ColorManager.black,
              ),
            ),
            IconButton(
              onPressed: () {
                downloadNote(context, widget.link ?? '', false);
              },
              icon: SvgPicture.asset(
                ImageAssets.download,
                color: widget.link == '' || widget.link == null ? ColorManager.grey : ColorManager.black,
              ),
            )
          ]
      ),
    );
  }
}
