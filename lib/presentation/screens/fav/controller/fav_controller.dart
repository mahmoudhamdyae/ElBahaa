import 'package:elbahaa/domain/repository/repository.dart';
import 'package:get/get.dart';

import '../../../../domain/models/courses/course.dart';

class FavController extends GetxController {

  final RxList<Course> courses = RxList.empty();

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;

  FavController(this._repository);

  @override
  void onInit() {
    super.onInit();
    getFav();
  }

  getFav() async {
    _status.value = RxStatus.loading();
    try {
      _repository.getFav().then((localCourses) {
        _status.value = RxStatus.success();
        courses.value = localCourses;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
      courses.value = [];
    }
  }

  void setFav(Course course) {
    try {
      _repository.setFav(course).then((value) {
        _status.value = RxStatus.success();
        courses.add(course);
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  void removeFav(Course course) {
    try {
      _repository.removeFav(course.id)
          .then((value) {
            _status.value = RxStatus.success();
            courses.remove(course);
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  bool isFav(Course course) {
    bool x = courses.any((element) => element.id == course.id);
    return x;
  }
}