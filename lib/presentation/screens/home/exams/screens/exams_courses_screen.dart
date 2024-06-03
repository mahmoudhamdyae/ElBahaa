import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/strings_manager.dart';
import '../../../../widgets/empty_screen.dart';
import '../../../../widgets/error_screen.dart';
import '../../../../widgets/loading_screen.dart';
import '../../../../widgets/top_bar.dart';
import '../controller/exams_controller.dart';
import '../widgets/exams_course_list.dart';

class ExamsCoursesScreen extends StatelessWidget {
  const ExamsCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('passed saff: ${Get.arguments['saff']}');
    debugPrint('passed term: ${Get.arguments['term']}');
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const TopBar(title:AppStrings.examsAndBanks),
          GetX<ExamsController>(
            init: Get.find<ExamsController>(),
            builder: (ExamsController controller) {
              if (controller.status.isLoading) {
                return const LoadingScreen();
              } else if (controller.status.isError) {
                return ErrorScreen(error: controller.status.errorMessage ?? '');
              } else if (controller.courses.isEmpty){
                return const EmptyScreen(emptyString: AppStrings.noExamCourses);
              } else {
                final courses = controller.courses;
                return ExamsCourseList(
                  subjects: courses,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
