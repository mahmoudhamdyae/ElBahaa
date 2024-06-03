import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/font_manager.dart';
import 'package:flutter/cupertino.dart';

import '../resources/styles_manager.dart';

class PriceWidget extends StatelessWidget {

  final int price;
  final String month;
  const PriceWidget({super.key, required this.price, required this.month});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$price د.ك',
          style: getLargeStyle(
            fontSize: FontSize.s20,
            color: ColorManager.secondary
          ),
        ),
        const SizedBox(height: 4.0,),
        Text(
          month,
          style: getLargeStyle(),
        )
      ],
    );
  }
}
