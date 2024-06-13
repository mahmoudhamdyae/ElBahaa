import 'package:elbahaa/domain/models/online_courses.dart';
import 'package:elbahaa/domain/repository/repository.dart';
import 'package:get/get.dart';

class OnlineCoursesController extends GetxController {

  final RxList<OnlineCourses> onlineCourses = RxList.empty();

  final Rx<RxStatus> _getStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get getStatus => _getStatus.value;

  final Rx<RxStatus> _postStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get postStatus => _postStatus.value;

  final Repository _repository;
  OnlineCoursesController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _getOnlineCourses();
  }

  void _getOnlineCourses() {
    _getStatus.value = RxStatus.loading();
    try {
      // _repository.getOnlineCourses().then((remoteOnlineCourses) {
        _getStatus.value = RxStatus.success();
        // onlineCourses.value = remoteOnlineCourses;
      // });
    } on Exception catch (e) {
      _getStatus.value = RxStatus.error(e.toString());
    }
  }

  void orderOnlineCourse() {
    _postStatus.value = RxStatus.loading();
    try {
      // _repository.orderOnlineCourse().then((remoteOnlineCourses) {
        _postStatus.value = RxStatus.success();
      // });
    } on Exception catch (e) {
      _postStatus.value = RxStatus.error(e.toString());
    }
  }
}