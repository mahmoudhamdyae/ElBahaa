import 'package:flutter/cupertino.dart';

bool isWide(BuildContext context) {
  // return MediaQuery.of(context).size.width >= 600;
  return MediaQuery.of(context).orientation == Orientation.landscape;
}