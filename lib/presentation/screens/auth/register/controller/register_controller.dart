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
    AppStrings.secondaryMarhala,
    AppStrings.universityMarhala,
  ].obs;
  RxString selectedMarhala = AppStrings.primaryMarhala.obs;

  RxList<String> sfoof = [''].obs;
  RxString selectedSaff = ''.obs;

  List<String> secondaryGrades = [];
  List<String> universityGrades = [];

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;

  RegisterController(this._repository);

  void toggleSecurePassword() {
    obscureText.value = !obscureText.value;
  }

  @override
  void onInit() {
    super.onInit();
    _getGrades();
  }

  void _getGrades() {
    try {
      _repository.getGrades().then((grades) {
        sfoof.value = grades.highSchool ?? [];
        selectedSaff.value = sfoof.first;
        secondaryGrades = grades.highSchool ?? [];
        universityGrades = grades.university ?? [];
      });
    } on Exception {
    }
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
      case AppStrings.secondaryMarhala:
        sfoof.value = secondaryGrades;
        break;
      case AppStrings.universityMarhala:
        sfoof.value = universityGrades;
        break;
    }
    selectedSaff.value = sfoof.first;
  }

  void chooseSaff(String newValue) {
    selectedSaff.value = newValue.toString();
  }
}