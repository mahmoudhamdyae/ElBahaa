import 'package:elbahaa/domain/models/courses/class_model.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:get/get.dart';

import '../../../../../domain/repository/repository.dart';

class RecordedCoursesController extends GetxController {

  final Rx<ClassModel> classModel = ClassModel([], []).obs;

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;

  RecordedCoursesController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _getRecordedCourses();
  }

  _getRecordedCourses() async {
    classModel.value = ClassModel([], []);
    _status.value = RxStatus.loading();
    Map<String, dynamic> args = Get.arguments;
    String saff = args['saff'];
    try {
      if (
          saff == AppStrings.saff1 ||
          saff == AppStrings.saff2 ||
          saff == AppStrings.saff3 ||
          saff == AppStrings.saff4 ||
          saff == AppStrings.saff5 ||
          saff == ''
      ) {
        _status.value = RxStatus.success();
        classModel.value = ClassModel([], []);
      } else {
        await _repository.getRecordedCourses(saff).then((remoteClassModel) {
          _status.value = RxStatus.success();
          classModel.value = remoteClassModel;
        });
      }
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
      classModel.value = ClassModel([], []);
    }
  }
}