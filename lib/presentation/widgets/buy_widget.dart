import 'package:elbahaa/presentation/screens/subscription/controller/subscription_controller.dart';
import 'package:elbahaa/presentation/widgets/buy_button.dart';
import 'package:elbahaa/presentation/widgets/buyed_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../domain/models/courses/course.dart';

class BuyWidget extends StatelessWidget {

  final Course course;
  final double width;
  const BuyWidget({super.key, required this.width, required this.course});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: Get.find<SubscriptionController>().isSubscribed(course.id) ? BuyedButton(course: course) : BuyButton(course: course),
    );
  }
}
