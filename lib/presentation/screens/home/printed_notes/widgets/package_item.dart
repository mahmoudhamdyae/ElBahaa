import 'package:elbahaa/presentation/screens/home/printed_notes/controller/printed_notes_controller.dart';
import 'package:elbahaa/presentation/screens/home/printed_notes/widgets/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../domain/models/package.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/styles_manager.dart';

class PackageItem extends StatelessWidget {

  final Package package;
  final int index;
  const PackageItem({super.key, required this.package, required this.index});

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
          Stack(
            children: [
              Row(
                children: [
                  Image.asset(
                    ImageAssets.baqaSilver,
                    height: 120,
                    width: 120,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.name ?? '',
                        style: getLargeStyle(
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      Text(
                        'تشمل ${package.book?.length} مذكرات',
                        style: getSmallStyle(
                          color: ColorManager.grey,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          Get.find<PrintedNotesController>().getNotesString(package),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: getSmallStyle(
                            color: ColorManager.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                left: 8.0,
                top: 24.0,
                child: Row(
                  children: [
                    Text(
                      '${package.price} د.ك',
                      style: getLargeStyle(
                          color: ColorManager.secondary
                      ),
                    ),
                    const SizedBox(width: 8.0,),
                    Text(
                      '${int.parse(package.price ?? '0') * 2} د.ك',
                      style: getLargeStyle(
                          color: ColorManager.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CartButtonPackage(package: package, index: index,),
        ],
      ),
    );
  }
}
