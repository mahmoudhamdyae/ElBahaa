import 'package:elbahaa/domain/repository/repository.dart';
import 'package:get/get.dart';

class MeController extends GetxController {

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  MeController(this._repository);

  Future<void> delAccount() async {
    _status.value = RxStatus.loading();
    try {
      await _repository.delAccount().then((value) {
        _status.value = RxStatus.success();
      });
    } on Exception catch (error) {
      _status.value = RxStatus.error(error.toString());
    }
  }

}