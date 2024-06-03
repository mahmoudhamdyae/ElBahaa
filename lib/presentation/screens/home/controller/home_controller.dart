import 'package:elbahaa/domain/models/teacher.dart';
import 'package:elbahaa/domain/repository/repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final RxList<Teacher> teachers = RxList.empty();

  final Repository _repository;
  HomeController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _getTeachers();
  }

  void _getTeachers() {
    _status.value = RxStatus.loading();
    try {
      _repository.getTeachers().then((remoteTeachers) {
        _status.value = RxStatus.success();
        teachers.value = remoteTeachers;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}