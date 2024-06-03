import 'package:elbahaa/domain/models/courses/course.dart';
import 'package:elbahaa/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';

class BuyedButton extends StatelessWidget {

  final Course course;
  const BuyedButton({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              width: 1.0,
              color: ColorManager.secondary,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () {
          },
          child: Row(
            children: [
              Text(
                AppStrings.buyed,
                style: getSmallStyle(
                  color: ColorManager.secondary,
                ),
              ),
              Expanded(child: Container()),
              SvgPicture.asset(
                ImageAssets.done
              ),
            ],
          )
      ),
    );
  }
}
