import 'package:elbahaa/domain/models/online_courses.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/screens/home/online_courses/widgets/cancel_order_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';

class OnlineCourseItem extends StatelessWidget {

  final OnlineCourses onlineCourse;
  const OnlineCourseItem({super.key, required this.onlineCourse});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: ColorManager.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // التاريخ
                      Row(
                        children: [
                          Text(
                            '${AppStrings.dateHint}: ',
                            style: getLargeStyle(),
                          ),
                          Text(
                            '${onlineCourse.date}',
                            style: getSmallStyle(),
                          ),
                        ],
                      ),
                      // الوقت
                      Row(
                        children: [
                          Text(
                            '${AppStrings.timeHint}: ',
                            style: getLargeStyle(),
                          ),
                          Text(
                            '${onlineCourse.time}',
                            style: getSmallStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0,),
                  // عدد الدقائق
                  Row(
                    children: [
                      Text(
                        '${AppStrings.minuteHint}: ',
                        style: getLargeStyle(),
                      ),
                      Text(
                        '${onlineCourse.minute}',
                        style: getSmallStyle(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0,),
                  // حالة الطلب
                  Row(
                    children: [
                      Text(
                        '${AppStrings.orderStatus}: ',
                        style: getLargeStyle(),
                      ),
                      Text(
                        '${onlineCourse.status}',
                        style: getSmallStyle(
                            color: onlineCourse.status == AppStrings.orderInProgress ?
                            Colors.orange :
                            onlineCourse.status == AppStrings.orderRejected ?
                            Colors.red :
                            Colors.green
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0,),
                ],
              ),
              onlineCourse.status == AppStrings.orderInProgress ? Positioned(
                left: 0,
                bottom: 0,
                child: FilledButton(
                  onPressed: () { showCancelOrderDialog(context, onlineCourse.id ?? -1); },
                  style: getFilledButtonStyle(),
                  child: Text(
                    AppStrings.cancelOrder,
                    style: getSmallStyle(
                      color: ColorManager.white
                    ),
                  ),
                ),
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}
