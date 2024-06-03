import 'package:elbahaa/domain/models/exam.dart';
import 'package:elbahaa/domain/repository/repository.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:get/get.dart';

import '../../../../../domain/models/courses/course.dart';

class ExamsController extends GetxController {

  final RxList<Course> courses = RxList.empty();
  final Rx<Exam> exam = Exam().obs;

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  ExamsController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _getExamsCourses();
  }

  void _getExamsCourses() {
    _status.value = RxStatus.loading();
    Map<String, dynamic> args = Get.arguments;
    String saff = args['saff'];
    String term = args['term'];
    try {
      _repository.getExamCourses(saff, term == AppStrings.termOne ? 1 : 2).then((remoteCourses) {
        _status.value = RxStatus.success();
        courses.value = remoteCourses;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  Future<void> getExamsAndCourses(int courseId) async {
    _status.value = RxStatus.loading();
    Map<String, dynamic> args = Get.arguments;
    String term = args['term'];
    try {
      await _repository.getExamsAndCourses(courseId, term == AppStrings.termOne ? 1 : 2).then((remoteExam) {
        _status.value = RxStatus.success();
        exam.value = remoteExam;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}