import 'package:elbahaa/domain/models/courses/course.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/screens/lesson/controller/lesson_controller.dart';
import 'package:elbahaa/presentation/screens/lesson/widgets/lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/models/lesson/wehda.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import 'dialogs/require_auth_dialog.dart';

class LessonsWidget extends StatefulWidget {
  final List<Wehda> wehdat;
  final bool isInLessonScreen;

  const LessonsWidget({super.key, required this.wehdat, required this.isInLessonScreen});

  @override
  State<LessonsWidget> createState() => _LessonsWidgetState();
}

class _LessonsWidgetState extends State<LessonsWidget> {
  int expanded = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: widget.wehdat.length,
        itemBuilder: (context, index) {
          return _buildLessonItem(widget.wehdat, widget.wehdat[index], index, expanded, (index) {
            setState(() {
              if (expanded == index) {
                expanded = -1;
              } else {
                expanded = index;
              }
            });
          });
        });
  }

  Widget _buildLessonItem(List<Wehda> wehdat, Wehda wehda, int index, int expanded, Function(int) expand) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: InkWell(
            onTap: () {
              expand(index);
            },
            child: Container(
                padding: const EdgeInsets.all(AppPadding.p8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s4),
                    color: ColorManager.white
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        wehda.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: ColorManager.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.s4,),
                    Icon(
                      expanded == index ? Icons.expand_less : Icons.expand_more,
                      color: ColorManager.black,
                    ),
                  ],
                )
            ),
          ),
        ),
        expanded == index ?
        ListView.builder(
          padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: wehda.lessons.length,
            itemBuilder: (context, lessonIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p8),
                child: InkWell(
                  onTap: () {
                    Course course = Get.arguments['course'];
                    if (wehda.lessons[lessonIndex].type == 'free' || Get.find<LessonController>().isSubscribed()) {
                      Get.find<LessonController>().selectedLesson = wehda.lessons[lessonIndex].obs;
                      Get.back();
                      Get.to(const LessonScreen(), arguments: { 'course': course });
                    } else {
                      showRequireAuthDialog(context, course);
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorManager.secondary, width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            lessonIndex < 9 ? '0${lessonIndex + 1}' : '${lessonIndex + 1}',
                            style: getLargeStyle(
                              fontWeight: FontWeight.w400,
                              color: ColorManager.secondary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0,),
                      SizedBox(
                        width: 200,
                        child: Text(
                          wehda.lessons[lessonIndex].name ?? '',
                          style: getSmallStyle(
                            color: wehda.lessons[lessonIndex].type == 'free' ||
                                Get.find<LessonController>().isSubscribed()
                                ? ColorManager.black
                                : ColorManager.grey
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(child: Container()),
                      wehda.lessons[lessonIndex].type == 'free' ?
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: ColorManager.secondary,
                        ),
                        child: Text(
                          AppStrings.free,
                          style: getSmallStyle(
                            color: ColorManager.white,
                          ),
                        ),
                      ) :
                      Get.find<LessonController>().isSubscribed() ? Container() : const Icon(
                        Icons.lock,
                        color: ColorManager.grey,
                      ),
                    ],
                  ),
                ),
              );
            }
        ) : Container()
      ],
    );
  }
}