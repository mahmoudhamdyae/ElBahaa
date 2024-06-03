import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/screens/lesson/widgets/tab_course_lessons.dart';
import 'package:elbahaa/presentation/screens/lesson/widgets/tab_morfaqat.dart';
import 'package:elbahaa/presentation/screens/lesson/widgets/tab_comments.dart';
import 'package:flutter/material.dart';

class CourseTabs extends StatefulWidget {

  final String? link;
  final int courseId;
  const CourseTabs({super.key, required this.link, required this.courseId});

  @override
  State<CourseTabs> createState() => _CourseTabsState();
}

class _CourseTabsState extends State<CourseTabs> {

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = 0;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        AppStrings.tabLessons,
                        style: getLargeStyle(),
                      ),
                    ),
                  )
              ),
              Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = 1;
                      });
                    },
                    child: Center(
                      child: Text(
                        AppStrings.tabAttachments,
                        style: getLargeStyle(),
                      ),
                    ),
                  )
              ),
              Expanded(
                flex: 3,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = 2;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Text(
                        AppStrings.tabComments,
                        style: getLargeStyle(),
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: selectedTab == 0 ? const Divider(
                        color: ColorManager.primary,
                        thickness: 3,
                      ) : Container(),
                    ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: selectedTab == 1 ? const Divider(
                      color: ColorManager.primary,
                      thickness: 3,
                    ) : Container(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: selectedTab == 2 ? const Divider(
                      color: ColorManager.primary,
                      thickness: 3,
                    ) : Container(),
                  ),
                ),
              ],
            ),
          ],
        ),
        selectedTab == 0 ? TabCourseLessons() : selectedTab == 1 ?
        TabMorfaqat(link: widget.link,):
        TabComments(courseId: widget.courseId,),
      ],
    );
  }
}
