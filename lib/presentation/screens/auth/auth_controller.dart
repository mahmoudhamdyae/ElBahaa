import 'package:elbahaa/domain/repository/repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  final Repository _repository;

  AuthController(this._repository);

  Future<void> signOut() async {
    return await _repository.signOut();
  }

  bool isUserLoggedIn() {
    return _repository.isUserLoggedIn();
  }

  String getUserName() {
    return _repository.getUserName();
  }

  String getPhoneNumber() {
    return _repository.getPhoneNumber();
  }

  bool isSubscribedAtOneSubjectAtLeast() {
    return _repository.isSubscribed();
  }
}