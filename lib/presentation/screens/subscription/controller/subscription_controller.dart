import 'package:elbahaa/domain/models/subscription_response.dart';
import 'package:get/get.dart';

import '../../../../domain/repository/repository.dart';

class SubscriptionController extends GetxController {

  final RxList<UserCourses> courses = RxList.empty();

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;

  SubscriptionController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _getSubscription();
  }

  Future<void> _getSubscription() async {
    _status.value = RxStatus.loading();
    try {
      await _repository.getSubscriptions().then((remoteCourses) {
        _status.value = RxStatus.success();
        courses.value = remoteCourses;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
      courses.value = [];
    }
  }

  bool isSubscribed(int courseId) {
    for (var element in courses) {
      if (element.id == courseId) {
        return true;
      }
    }
    return false;
  }

  Future<bool> isSubscribedAtOneSubjectAtLeast() async {
    await _getSubscription();
    _repository.saveIsSubscribed(courses.isNotEmpty);
    return courses.isNotEmpty;
  }
}