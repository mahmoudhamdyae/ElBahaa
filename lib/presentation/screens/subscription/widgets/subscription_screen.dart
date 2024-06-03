import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/screens/auth/auth_controller.dart';
import 'package:elbahaa/presentation/screens/subscription/controller/subscription_controller.dart';
import 'package:elbahaa/presentation/screens/subscription/widgets/subscription_courses_list.dart';
import 'package:elbahaa/presentation/widgets/empty_screen.dart';
import 'package:elbahaa/presentation/widgets/error_screen.dart';
import 'package:elbahaa/presentation/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/require_log_in_view.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Get.find<AuthController>().isUserLoggedIn() ?
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0, bottom: 8.0),
          child: Text(
            AppStrings.favCourses,
            style: getLargeStyle(),
          ),
        ),
        Expanded(
          child: GetX<SubscriptionController>(
            init: Get.find<SubscriptionController>(),
            builder: (SubscriptionController controller) {
              if (controller.status.isLoading) {
                return const LoadingScreen();
              } else if (controller.status.isError) {
                return ErrorScreen(error: controller.status.errorMessage ?? '');
              } else if (controller.courses.isEmpty) {
                return const EmptyScreen(emptyString: AppStrings.emptySubscriptions);
              } else {
                final courses = controller.courses;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: SubscriptionCoursesList(courses: courses),
                );
              }
            },
          ),
        ),
      ],
    ) : const RequireLogInView();
  }
}
