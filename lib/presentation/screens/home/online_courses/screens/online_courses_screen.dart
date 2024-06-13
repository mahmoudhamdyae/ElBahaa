import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/screens/home/online_courses/controller/online_courses_controller.dart';
import 'package:elbahaa/presentation/screens/home/online_courses/widgets/online_courses_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/strings_manager.dart';
import '../../../../widgets/empty_screen.dart';
import '../../../../widgets/error_screen.dart';
import '../../../../widgets/loading_screen.dart';
import '../../../../widgets/top_bar.dart';

class OnlineCoursesScreen extends StatelessWidget {
  const OnlineCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // todo: add order
        },
        backgroundColor: ColorManager.secondary,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: ColorManager.white,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const TopBar(title:AppStrings.onlineCourses),
          GetX<OnlineCoursesController>(
            init: Get.find<OnlineCoursesController>(),
            builder: (OnlineCoursesController controller) {
              if (controller.getStatus.isLoading) {
                return const LoadingScreen();
              } else if (controller.getStatus.isError) {
                return ErrorScreen(error: controller.getStatus.errorMessage ?? '');
              } else if (controller.onlineCourses.isEmpty){
                return const EmptyScreen(emptyString: AppStrings.noOnlineCourses);
              } else {
                final onlineCourses = controller.onlineCourses;
                return OnlineCoursesList(
                  onlineCourses: onlineCourses,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
