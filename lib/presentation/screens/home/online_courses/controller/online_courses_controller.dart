import 'package:elbahaa/domain/models/online_courses.dart';
import 'package:elbahaa/domain/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnlineCoursesController extends GetxController {

  final RxList<OnlineCourses> onlineCourses = RxList.empty();
  final TextEditingController date = TextEditingController();
  final TextEditingController time = TextEditingController();
  final TextEditingController minute = TextEditingController();
  final TextEditingController desc = TextEditingController();

  final Rx<RxStatus> _getStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get getStatus => _getStatus.value;

  final Rx<RxStatus> _postStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get postStatus => _postStatus.value;

  final Rx<RxStatus> _delStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get delStatus => _delStatus.value;

  final Repository _repository;
  OnlineCoursesController(this._repository);

  @override
  void onInit() {
    super.onInit();
    getOnlineCourses();
  }

  @override
  void onClose() {
    super.dispose();
    date.dispose();
    time.dispose();
    minute.dispose();
    desc.dispose();
  }

  void getOnlineCourses() {
    _getStatus.value = RxStatus.loading();
    try {
      _repository.getOnlineCourses().then((remoteOnlineCourses) {
        _getStatus.value = RxStatus.success();
        onlineCourses.value = remoteOnlineCourses;
      });
    } on Exception catch (e) {
      _getStatus.value = RxStatus.error(e.toString());
    }
  }

  Future<void> orderOnlineCourse() async {
    _postStatus.value = RxStatus.loading();
    try {
      await _repository.createOnlineCourse(
          date.text,
          time.text,
          minute.text,
          desc.text
      ).then((value) {
        _postStatus.value = RxStatus.success();
      });
    } on Exception catch (e) {
      _postStatus.value = RxStatus.error(e.toString());
    }
  }

  Future<void> delOnlineCourse(int orderId) async {
    _delStatus.value = RxStatus.loading();
    try {
      await _repository.cancelOrder(orderId).then((value) {
        _delStatus.value = RxStatus.success();
      });
    } on Exception catch (e) {
      _delStatus.value = RxStatus.error(e.toString());
    }
  }
}