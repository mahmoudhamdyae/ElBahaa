import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../../resources/styles_manager.dart';

showChooseTermDialog(
    BuildContext context, String saff, Function(String) onTap) {
  final List<String> terms = [
    AppStrings.termOne,
    AppStrings.termTwo,
  ];
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
                saff,
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
                  itemCount: terms.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        onTap(terms[index]);
                      },
                      child: ListTile(
                        title: Text(
                          terms[index],
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
