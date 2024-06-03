import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../../resources/styles_manager.dart';

showChooseSaffDialog(
    BuildContext context, String marhala, Function(String) onTap) {
  final List<String> sfoof = _getSfoof(marhala);
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // The shape of the dialog
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          // The content of the dialog
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                marhala,
                style: getLargeStyle(),
              ),
              const SizedBox(
                height: AppSize.s16,
              ),
              SizedBox(
                height: 300,
                width: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: sfoof.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        onTap(sfoof[index]);
                      },
                      child: ListTile(
                        title: Text(
                          sfoof[index],
                          style: getSmallStyle(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      });
}

List<String> _getSfoof(String marhala) {
  switch (marhala) {
    case AppStrings.primaryMarhala:
      return [
        // AppStrings.saff1,
        // AppStrings.saff2,
        // AppStrings.saff3,
        AppStrings.saff4,
        AppStrings.saff5,
      ];
    case AppStrings.mediumMarhala:
      return [
        AppStrings.saff6,
        AppStrings.saff7,
        AppStrings.saff8,
        AppStrings.saff9,
      ];
    case AppStrings.secondaryMarhala:
      return [
        AppStrings.saff10,
        AppStrings.saff11,
        AppStrings.saff12,
      ];
    default:
      return [];
  }
}
