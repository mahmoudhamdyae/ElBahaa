import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class RateWidget extends StatelessWidget {

  final String rate;
  const RateWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rate,
          style: getLargeStyle(
            color: ColorManager.primary,
          ),
        ),
        const SizedBox(width: 4.0,),
        const Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Icon(
            Icons.star,
            color: ColorManager.primary,
            size: 16,
          ),
        ),
      ],
    );
  }
}
