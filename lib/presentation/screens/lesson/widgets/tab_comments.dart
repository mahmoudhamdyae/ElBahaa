import 'package:elbahaa/presentation/screens/lesson/controller/lesson_controller.dart';
import 'package:elbahaa/presentation/screens/lesson/widgets/comments_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/constants_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../subscription/controller/subscription_controller.dart';

class TabComments extends StatelessWidget {

  final int courseId;
  const TabComments({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          Get.find<SubscriptionController>().isSubscribed(courseId)
          // true
              ?
          ListView(
            padding: const EdgeInsets.all(0.0),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              TextFormField(
                controller: Get.find<LessonController>().commentEditText,
                onChanged: (newComment) => Get.find<LessonController>().updateComment(newComment),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                style: getLargeStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.grey,
                ),
                decoration: getTextFieldDecoration(
                  hint: AppStrings.yourComment,
                  onPressed: () { },
                  prefixIcon: Icons.comment,
                ),
              ),
              const SizedBox(height: 8.0,),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: getFilledButtonStyle(),
                  onPressed: /*Get.find<LessonController>().commentEditText.text == '' ? null :*/ () {
                    LessonController controller = Get.find<LessonController>();
                    controller.addComment().then((value) {
                    Get.showSnackbar(
                      const GetSnackBar(
                        title: null,
                        message: AppStrings.commentAdded,
                        duration: Duration(seconds: AppConstants.snackBarTime),
                      ),
                    );
                  });},
                  child: Text(
                    AppStrings.addComment,
                    style: getSmallStyle(
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
            ],
          )
              :
          Container(),
          const CommentsList(),
        ],
      ),
    );
  }
}
