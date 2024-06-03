import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MeItem extends StatelessWidget {

  final String icon;
  final String title;
  final Function() action;
  const MeItem({super.key, required this.icon, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(
              width: 17,
              height: 17,
              child: SvgPicture.asset(
                icon,
                color: ColorManager.secondary,
              ),
            ),
            const SizedBox(width: 16.0,),
            Text(
              title,
              style: getLargeStyle(
                fontWeight: FontWeight.w400,
                color: title == AppStrings.signOut ? ColorManager.secondary : ColorManager.black
              ),
            )
          ],
        ),
      ),
    );
  }
}
