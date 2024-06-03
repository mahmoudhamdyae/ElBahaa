import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import '../../domain/models/courses/course.dart';
import '../resources/assets_manager.dart';
import '../screens/fav/controller/fav_controller.dart';

class BookmarkCourse extends StatelessWidget {

  final Course course;
  const BookmarkCourse({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GetX<FavController>(
      builder: (FavController controller) {
        return IconButton(
          onPressed: () {
            if (controller.isFav(course)) {
              controller.removeFav(course);
            } else {
              controller.setFav(course);
            }
          },
          icon: controller.isFav(course) ?
          SvgPicture.asset(
            ImageAssets.bookmarkSelected,
            height: 32,
            width: 20,
          )
              :
          SvgPicture.asset(
            ImageAssets.bookmark,
            height: 32,
            width: 20,
          ),
        );
      },
    );
  }
}
