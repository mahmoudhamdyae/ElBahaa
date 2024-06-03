import 'package:elbahaa/domain/models/courses/course.dart';
import 'package:elbahaa/domain/models/lesson/wehda.dart';
import 'package:elbahaa/domain/models/subscription_response.dart';
import 'package:pair/pair.dart';

import '../models/city.dart';
import '../models/courses/class_model.dart';
import '../models/exam.dart';
import '../models/lesson/lesson.dart';
import '../models/notes/note.dart';
import '../models/package.dart';
import '../models/teacher.dart';

abstract class Repository {

  // Local Data Source
  Future<bool> isFirstTime();
  bool isUserLoggedIn();
  String getUserName();
  String getGrade();
  String getPhoneNumber();
  Future<void> setFav(Course course);
  Future<List<Course>> getFav();
  Future<void> removeFav(int courseId);
  bool isSubscribed();
  void saveIsSubscribed(bool isSubscribed);

  // Notes Cart
  Future<void> addNoteToCart(String noteId);
  Future<void> removeNoteFromCart(String noteId);
  bool isNoteInCart(String noteId);
  Future<Pair<List<Note>, List<Package>>> getAllCart();

  // Packages Cart
  Future<void> addPackageToCart(String packageId);
  Future<void> removePackageFromCart(String packageId);
  bool isPackageInCart(String packageId);

  // Account Service
  Future<void> register(String userName, String phone, String password, String grade, String group);
  Future<void> logIn(String phone, String password);
  Future<void> signOut();

  // Remote Data Source
  Future<ClassModel> getRecordedCourses(String marhala);
  Future<List<Wehda>> getTutorials(int courseId);
  Future<String> askQuestion(String question);
  Future<Pair<List<Note>, List<Package>>> getNotes(String marhala);
  Future<void> order(String userName, String phone, int cityId, String address, List<Note> notes, List<int> count, List<Package> packages, List<int> countPackage);
  Future<List<Teacher>> getTeachers();
  Future<List<City>> getCities();
  Future<List<UserCourses>> getSubscriptions();
  Future<void> addComment(String comment, Lesson video, int teacherId);
  Future<List<Course>> getExamCourses(String marhala, int term);
  Future<Exam> getExamsAndCourses(int courseId, int term);
  Future<void> pay(int courseId);
  Future<void> delAccount();
}