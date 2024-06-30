import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/screens/auth/auth_controller.dart';
import 'package:elbahaa/presentation/screens/home/online_courses/screens/online_courses_screen.dart';
import 'package:elbahaa/presentation/widgets/dialogs/choose_marhala_dialog.dart';
import 'package:elbahaa/presentation/widgets/dialogs/choose_term_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/models/home_ui.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'dialogs/require_login_dialog.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({super.key, required HomeUI item}) : _item = item;

  final HomeUI _item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s16),
        color: ColorManager.secondary,
      ),
      child: InkWell(
        onTap: () {
          if (_item.name == AppStrings.recordedCourses) {
            showChooseMarhalaDialog(context, true, (marhala) {
              _item.action(marhala, '');
            });
          } else if (_item.name == AppStrings.printedNotes) {
            showChooseMarhalaDialog(context, false, (marhala) {
              _item.action(marhala, '');
            });
          } else if (_item.name == AppStrings.examsAndBanks) {
            showChooseMarhalaDialog(context, true, (marhala) {
              showChooseTermDialog(context, marhala, (String term) {
                _item.action(marhala, term);
              });
            });
          } else if (_item.name == AppStrings.onlineCourses) {
            if (Get.find<AuthController>().isUserLoggedIn()) {
              Get.to(const OnlineCoursesScreen());
            } else {
              showRequireLoginDialog(context);
            }
          } else {
            _item.action('', '');
          }
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSize.s16),
                  topRight: Radius.circular(AppSize.s16),
              ),
              child: Image.asset(
                _item.icon,
                height: 140,
                width: 200,
                fit: (_item.name == AppStrings.examsAndBanks) ? BoxFit.fill : BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: AppSize.s8,),
            Text(
              _item.name,
              textAlign: TextAlign.center,
              style: getLargeStyle(color: ColorManager.white),
            ),
          ],
        ),
      ),
    );
  }
}
