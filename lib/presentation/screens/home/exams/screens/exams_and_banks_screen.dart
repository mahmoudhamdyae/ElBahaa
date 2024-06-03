import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/screens/home/exams/widgets/exam_list.dart';
import 'package:elbahaa/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../domain/models/courses/course.dart';
import '../../../../../domain/models/exam.dart';
import '../../../../widgets/error_screen.dart';
import '../../../../widgets/loading_screen.dart';
import '../controller/exams_controller.dart';

class ExamsAndBanksScreen extends StatelessWidget {

  final Course course;
  const ExamsAndBanksScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const TopBar(title: AppStrings.examsAndBanks),
          GetX<ExamsController>(
            init: Get.find<ExamsController>(),
            builder: (ExamsController controller) {
              if (controller.status.isLoading) {
                return const LoadingScreen();
              } else if (controller.status.isError) {
                return ErrorScreen(error: controller.status.errorMessage ?? '');
              } else {
                Exam exam = controller.exam.value;
                return ExamList(exam: exam,);
              }
            },
          ),
        ],
      ),
    );
  }
}
