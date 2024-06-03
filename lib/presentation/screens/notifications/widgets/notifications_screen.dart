import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/models/notification.dart';
import '../../../resources/strings_manager.dart';

class NotificationsScreen extends StatelessWidget {

  final List<NotificationModel> notifications = [
    // NotificationModel('هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص', '3 ساعة'),
    // NotificationModel('هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص', '12 سبتمبر'),
    // NotificationModel('هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص', '12 سبتمبر'),
  ];
  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      )
                  ),
                ),
                Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          AppStrings.notifications,
                          style: getLargeStyle(),
                        ),
                      ),
                    )
                )
              ],
            ),
            const EmptyScreen(emptyString: AppStrings.noNotifications),
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: const ClampingScrollPhysics(),
            //   itemCount: notifications.length,
            //   itemBuilder: (BuildContext context, int index) {
            //   return NotificationItem(notification: notifications[index],);
            // },
            // ),
          ],
        ),
      ),
    );
  }
}
