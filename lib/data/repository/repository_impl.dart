import 'package:elbahaa/data/remote/remote_data_source.dart';
import 'package:elbahaa/domain/models/city.dart';
import 'package:elbahaa/domain/models/courses/course.dart';
import 'package:elbahaa/domain/models/lesson/wehda.dart';
import 'package:elbahaa/domain/models/notes/note.dart';
import 'package:elbahaa/domain/models/subscription_response.dart';
import 'package:elbahaa/domain/models/teacher.dart';
import 'package:elbahaa/domain/repository/repository.dart';
import 'package:pair/pair.dart';

import '../../domain/models/courses/class_model.dart';
import '../../domain/models/exam.dart';
import '../../domain/models/grades.dart';
import '../../domain/models/lesson/lesson.dart';
import '../../domain/models/package.dart';
import '../local/local_data_source.dart';

class RepositoryImpl extends Repository {

  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  RepositoryImpl(this._remoteDataSource, this._localDataSource);

  // Local Data Source

  @override
  Future<bool> isFirstTime() {
    return _localDataSource.isFirstTime();
  }

  @override
  bool isUserLoggedIn() {
    return _localDataSource.isUserLoggedIn();
  }

  @override
  String getUserName() {
    return _localDataSource.getUserName();
  }

  @override
  String getGrade() {
    return _localDataSource.getGrade();
  }

  @override
  String getPhoneNumber() {
    return _localDataSource.getPhoneNumber();
  }

  @override
  Future<void> setFav(Course course) {
    return _localDataSource.setFav(course);
  }

  @override
  Future<List<Course>> getFav() {
    return _localDataSource.getFav();
  }

  @override
  Future<void> removeFav(int courseId) {
    return _localDataSource.removeFav(courseId);
  }

  @override
  bool isSubscribed() {
    return _localDataSource.isSubscribed();
  }

  @override
  void saveIsSubscribed(bool isSubscribed) {
    _localDataSource.saveIsSubscribed(isSubscribed);
  }

  // Notes Cart

  @override
  Future<void> addNoteToCart(String noteId) {
    return _localDataSource.addNoteToCart(noteId);
  }

  @override
  bool isNoteInCart(String noteId) {
    return _localDataSource.isNoteInCart(noteId);
  }

  @override
  Future<void> removeNoteFromCart(String noteId) {
    return _localDataSource.removeNoteFromCart(noteId);
  }

  @override
  Future<Pair<List<Note>, List<Package>>> getAllCart() {
    return _remoteDataSource.getAllCart(_localDataSource.getAllNotesCart(), _localDataSource.getAllPackagesCart());
  }

  // Packages Cart

  @override
  Future<void> addPackageToCart(String packageId) {
    return _localDataSource.addPackageToCart(packageId);
  }

  @override
  Future<void> removePackageFromCart(String packageId) {
    return _localDataSource.removePackageFromCart(packageId);
  }

  @override
  bool isPackageInCart(String packageId) {
    return _localDataSource.isPackageInCart(packageId);
  }

  // Account Service

  @override
  Future<void> logIn(String phone, String password) {
    return _remoteDataSource.logIn(phone, password).then((data) {
      _localDataSource.setUserId(data['user']['id']);
      _localDataSource.setUserName(data['user']['name']);
      _localDataSource.setGrade(data['user']['group']);
      _localDataSource.setPhoneNumber(data['user']['phone']);
      _localDataSource.setUserLoggedIn();
      _remoteDataSource.sendTokenAndUserId(_localDataSource.getUserId());
    });
  }

  @override
  Future<Grades> getGrades() async {
    return await _remoteDataSource.getGrades();
  }

  @override
  Future<void> register(String userName, String phone, String password, String grade, String group) {
    return _remoteDataSource.register(userName, phone, password, grade, group).then((value) {
      _remoteDataSource.sendTokenAndUserId(_localDataSource.getUserId());
    });
  }

  @override
  Future<void> signOut() async {
    _remoteDataSource.getFcmToken();
    return await _localDataSource.signOut();
  }

  // Remote Data Source

  @override
  Future<ClassModel> getRecordedCourses(String marhala) async {
    return _remoteDataSource.getRecordedCourses(marhala);
  }

  @override
  Future<List<Wehda>> getTutorials(int courseId) {
    return _remoteDataSource.getTutorials(courseId);
  }

  @override
  Future<String> askQuestion(String question) {
    return _remoteDataSource.askQuestion(question);
  }

  @override
  Future<Pair<List<Note>, List<Package>>> getNotes(String marhala) async {
    return await _remoteDataSource.getNotes(marhala);
  }

  @override
  Future<void> order(String userName, String phone, int cityId, String address, List<Note> notes, List<int> count, List<Package> packages, List<int> countPackage) async {
    return await _remoteDataSource.order(userName, phone, cityId, address, notes, count, packages, countPackage).then((value) {
      _localDataSource.removeAllFromCart();
    });
  }

  @override
  Future<List<Teacher>> getTeachers() {
    return _remoteDataSource.getTeachers();
  }

  @override
  Future<List<City>> getCities() {
    return _remoteDataSource.getCities();
  }

  @override
  Future<List<UserCourses>> getSubscriptions() {
    return _remoteDataSource.getSubscriptions(_localDataSource.getUserId());
  }

  @override
  Future<void> addComment(String comment, Lesson video, int teacherId) async {
    return await _remoteDataSource.addComment(comment, _localDataSource.getUserId(), video, teacherId, _localDataSource.getUserName());
  }

  @override
  Future<List<Course>> getExamCourses(String marhala, int term) async {
    return await _remoteDataSource.getExamCourses(marhala, term);
  }

  @override
  Future<Exam> getExamsAndCourses(int courseId, int term) async {
    return await _remoteDataSource.getExamsAndCourses(courseId, term);
  }

  @override
  Future<void> pay(int courseId) async {
    await _remoteDataSource.pay(courseId, _localDataSource.getUserId());
  }

  @override
  Future<void> delAccount() async {
    return await _remoteDataSource.delAccount(_localDataSource.getUserId()).then((value) {
      signOut();
    });
  }
}