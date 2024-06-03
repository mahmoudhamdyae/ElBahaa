// import 'package:elbahaa/domain/repository/repository.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// class UpdateProfileController extends GetxController {
//
//   final TextEditingController userName = TextEditingController();
//   final TextEditingController phone = TextEditingController();
//   final TextEditingController email = TextEditingController();
//   final TextEditingController  password = TextEditingController();
//   final RxBool obscureText = true.obs;
//
//   final Rx<RxStatus> _getDataStatus = Rx<RxStatus>(RxStatus.empty());
//   RxStatus get getDataStatus => _getDataStatus.value;
//   final Rx<RxStatus> _updateStatus = Rx<RxStatus>(RxStatus.empty());
//   RxStatus get updateStatus => _updateStatus.value;
//
//   final Repository _repository;
//   UpdateProfileController(this._repository);
//
//   @override
//   void onClose() {
//     super.onClose();
//     phone.text = '';
//     userName.text = '';
//     phone.text = '';
//     password.text = '';
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     _getProfileData();
//   }
//
//   void toggleSecurePassword() {
//     obscureText.value = !obscureText.value;
//   }
//
//   void _getProfileData() {
//     _getDataStatus.value = RxStatus.loading();
//     try {
//       // _repository.getProfileData().then((value) {
//         _getDataStatus.value = RxStatus.success();
//         phone.text = '1';
//         userName.text = '2';
//         phone.text = '3';
//         password.text = '4';
//       // });
//     } on Exception catch (e) {
//       _getDataStatus.value = RxStatus.error(e.toString());
//     }
//   }
//
//   Future<void> updateProfileData() async {
//     _updateStatus.value = RxStatus.loading();
//     try {
//       // await _repository.updateProfileData(
//       //     userName.text,
//       //     phone.text,
//       //     email.text,
//       //     password.text
//       // ).then((value) {
//         _updateStatus.value = RxStatus.success();
//       // });
//     } on Exception catch (e) {
//       _updateStatus.value = RxStatus.error(e.toString());
//     }
//   }
// }