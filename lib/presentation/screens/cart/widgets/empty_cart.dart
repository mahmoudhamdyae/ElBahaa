import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';

import '../../../resources/assets_manager.dart';

class EmptyCart extends StatelessWidget {

  final String emptyString;
  const EmptyCart({super.key, required this.emptyString});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageAssets.emptyCart,
            height: AppSize.s190,
          ),
          const SizedBox(height: AppSize.s40,),
          Text(
            emptyString,
            style: getLargeStyle(),
          ),
        ],
      ),
    );
  }
}
