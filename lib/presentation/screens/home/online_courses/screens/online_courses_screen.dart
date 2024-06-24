import 'package:elbahaa/domain/models/online_courses.dart';
import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/screens/home/online_courses/controller/online_courses_controller.dart';
import 'package:elbahaa/presentation/screens/home/online_courses/widgets/online_courses_list.dart';
import 'package:elbahaa/presentation/screens/home/online_courses/widgets/order_online_course_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/strings_manager.dart';
import '../../../../resources/styles_manager.dart';
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
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: ColorManager.white,
                  title: Text(
                    AppStrings.onlineCoursesDialogTitle,
                    style: getLargeStyle(),
                  ),
                  content: const OrderOnlineCourseDialog(),
                );
              });
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
                List<OnlineCourses> onlineCourses = controller.onlineCourses;
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
