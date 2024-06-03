import 'package:elbahaa/core/constants.dart';
import 'package:elbahaa/core/launch_site.dart';
import 'package:elbahaa/domain/models/courses/course.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';

class BuyButton extends StatelessWidget {

  final Course course;
  const BuyButton({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: getFilledButtonStyle(),
        onPressed: () {
          launchSite(Constants.siteUrl);
        },
        child: Text(
          AppStrings.buy,
          style: getSmallStyle(
            color: ColorManager.white,
          ),
        )
    );
  }
}
