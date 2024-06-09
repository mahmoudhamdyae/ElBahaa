import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/widgets/dialogs/choose_marhala_dialog.dart';
import 'package:elbahaa/presentation/widgets/dialogs/choose_term_dialog.dart';
import 'package:flutter/material.dart';

import '../../domain/models/home_ui.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

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
              // showChooseTermDialog(context, saff, (String term) {
              //   _item.action(marhala, saff, term);
                _item.action(marhala, '2');
              // });
            });
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
                // height: 120,
                fit: BoxFit.fill,
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
