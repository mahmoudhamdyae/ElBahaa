import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/screens/lesson/controller/lesson_controller.dart';
import 'package:elbahaa/presentation/screens/lesson/widgets/vimeo_video_widget.dart';
import 'package:elbahaa/presentation/widgets/empty_screen.dart';
import 'package:elbahaa/presentation/widgets/error_screen.dart';
import 'package:elbahaa/presentation/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/models/courses/course.dart';
import '../../../resources/color_manager.dart';

import '../../../resources/styles_manager.dart';
import 'course_tabs.dart';

class LessonScreen extends StatefulWidget {

   const LessonScreen({super.key});

  @visibleForTesting
  String extractVideoId(String url) {
    RegExp regExp = RegExp(r'/(\d+)\??');
    Match? match = regExp.firstMatch(url);

    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      // throw Exception('Video ID not found in URL');
      return '';
    }
  }

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetX<LessonController>(
            init: Get.find<LessonController>(),
            builder: (LessonController controller) {
              if (controller.status.isLoading) {
                return const LoadingScreen();
              } else if (controller.status.isError) {
                return ErrorScreen(error: controller.status.errorMessage ?? '');
              } else if (controller.wehdat.isEmpty) {
                return const EmptyScreen(emptyString: AppStrings.emptyTutorials);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vimeo Video
                  controller.selectedLesson.value.link == '' || controller.selectedLesson.value.link == null ? const SizedBox(height: 60.0,) : SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: PlayVideoFromVimeo(vimeoVideoUrl: widget.extractVideoId(controller.selectedLesson.value.link ?? '')
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      right: 16.0,
                      left: 16.0,
                      bottom: 0.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (Get.arguments['course'] as Course).name,
                          style: getLargeStyle(),
                        ),
                        SizedBox(
                          width: 225,
                          child: Text(
                            controller.selectedLesson.value.name ?? '',
                            style: getLargeStyle(),
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0.0,
                      right: 16.0,
                      left: 16.0,
                      bottom: 16.0,
                    ),
                    child: Text(
                      (Get.arguments['course'] as Course).teacher,
                      style: getSmallStyle(
                        color: const Color(0xff808080),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CourseTabs(link: controller.selectedLesson.value.pdf ?? '', courseId: (Get.arguments['course'] as Course).id),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, right: 8.0),
            child: IconButton(
                onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorManager.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}

