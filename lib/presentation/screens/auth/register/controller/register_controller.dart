import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../domain/repository/repository.dart';
import '../../../../resources/strings_manager.dart';

class RegisterController extends GetxController {

  final TextEditingController userName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final RxBool obscureText = true.obs;
  final RxList<String> marahel = [
    AppStrings.primaryMarhala,
    AppStrings.mediumMarhala,
    AppStrings.secondaryMarhala,
    AppStrings.qodoratMarhala,
    AppStrings.toeflMarhala,
    AppStrings.ieltsMarhala,
  ].obs;
  RxString selectedMarhala = AppStrings.primaryMarhala.obs;

  RxList<String> sfoof = [
    AppStrings.saff1,
    AppStrings.saff2,
    AppStrings.saff3,
    AppStrings.saff4,
    AppStrings.saff5,
  ].obs;
  RxString selectedSaff = AppStrings.saff1.obs;

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;

  RegisterController(this._repository);

  void toggleSecurePassword() {
    obscureText.value = !obscureText.value;
  }

  Future<void> register() async {
    _status.value = RxStatus.loading();
    try {
      await _repository.register(
          userName.text,
          phone.text,
          password.text,
          selectedMarhala.value,
          selectedSaff.value
      ).then((remoteCourses) async {
        await _repository.logIn(phone.text, password.text).then((value) {
          _status.value = RxStatus.success();
        });
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  void chooseMarhala(String newValue) {
    selectedMarhala.value = newValue;
    switch(selectedMarhala.value) {
      case AppStrings.primaryMarhala:
        sfoof.value = [
          AppStrings.saff1,
          AppStrings.saff2,
          AppStrings.saff3,
          AppStrings.saff4,
          AppStrings.saff5,
        ];
        break;
      case AppStrings.mediumMarhala:
        sfoof.value = [
          AppStrings.saff6,
          AppStrings.saff7,
          AppStrings.saff8,
          AppStrings.saff9,
        ];
        break;
      case AppStrings.secondaryMarhala:
        sfoof.value = [
          AppStrings.saff10,
          AppStrings.saff11,
          AppStrings.saff12,
        ];
        break;
      case AppStrings.qodoratMarhala:
        sfoof.value = [
          AppStrings.qodoratMarhala,
        ];
        break;
      case AppStrings.toeflMarhala:
        sfoof.value = [
          AppStrings.toeflMarhala,
        ];
        break;
      case AppStrings.ieltsMarhala:
        sfoof.value = [
          AppStrings.ieltsMarhala,
        ];
        break;
    }
    selectedSaff.value = sfoof.first;
  }

  void chooseSaff(String newValue) {
    selectedSaff.value = newValue.toString();
  }
}