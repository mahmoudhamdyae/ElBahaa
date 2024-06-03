import 'package:elbahaa/domain/models/package.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/screens/home/printed_notes/controller/printed_notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import 'delete_cart_package_item_dialog.dart';

class CartPackageItem extends StatelessWidget {

  final Package package;
  final int index;
  const CartPackageItem({super.key, required this.package, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.asset(
                  ImageAssets.baqaSilver,
                  height: 100,
                  width: 80,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 90,
                      child: Text(
                        package.name ?? '',
                        style: getLargeStyle(
                            fontWeight: FontWeight.w400
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      package.class1 ?? '',
                      style: getSmallStyle(),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Delete Button
                  IconButton(
                    onPressed: () => showDeleteCartPackageItemDialog(context, package, index),
                    icon: const Icon(
                      Icons.delete,
                      color: ColorManager.error,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
                    child: Row(
                      children: [
                        Text(
                          '${package.price} د.ك',
                          style: getLargeStyle(
                              fontSize: FontSize.s20,
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
            ],
          ),
          // الكمية
          Row(
            children: [
              Expanded(child: Container()),
              Text(
                AppStrings.quantity,
                style: getLargeStyle(),
              ),
              Expanded(child: Container()),
              SizedBox(
                width: 110,
                child: GetX<PrintedNotesController>(
                  init: Get.find<PrintedNotesController>(),
                  builder: (PrintedNotesController controller) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(color: ColorManager.grey)
                      ),
                      child: Row(
                        children: [
                          // - Button
                          InkWell(
                              onTap: () {
                                debugPrint('Minus Clicked');
                                controller.decrementCountPackage(index);
                              }, child: Text(
                            '-',
                            style: TextStyle(
                              color: controller.countPackages[index] != 1 ? ColorManager.black : ColorManager.grey,
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 8.0,
                              left: 8.0,
                              top: 6,
                            ),
                            child: Text(
                              controller.countPackages[index].toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          // + Button
                          InkWell(
                              onTap: () {
                                debugPrint('Plus Clicked');
                                controller.incrementCountPackage(index);
                              }, child: const Text(
                            '+',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
