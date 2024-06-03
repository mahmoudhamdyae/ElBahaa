import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elbahaa/core/converters.dart';
import 'package:elbahaa/domain/models/city.dart';
import 'package:elbahaa/domain/models/courses/course.dart';
import 'package:elbahaa/domain/models/exam.dart';
import 'package:elbahaa/domain/models/lesson/wehda.dart';
import 'package:elbahaa/domain/models/notes/note.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pair/pair.dart';

import '../../core/constants.dart';
import '../../domain/models/courses/class_model.dart';

import '../../domain/models/lesson/lesson.dart';
import '../../domain/models/package.dart';
import '../../domain/models/subscription_response.dart';
import '../../domain/models/teacher.dart';
import '../network_info.dart';

abstract class RemoteDataSource {
  Future register(String userName, String phone, String password, String grade,
      String group);
  Future<dynamic> logIn(String phone, String password);
  Future<String> getFcmToken();
  void sendTokenAndUserId(int userId);

  Future<ClassModel> getRecordedCourses(String marhala);
  Future<List<Wehda>> getTutorials(int courseId);
  Future<String> askQuestion(String question);
  Future<Pair<List<Note>, List<Package>>> getNotes(String marhala);
  Future<Pair<List<Note>, List<Package>>> getAllCart(
      List<String> notesId, List<String> packagesId);
  Future<void> order(
      String userName,
      String phone,
      int cityId,
      String address,
      List<Note> notes,
      List<int> count,
      List<Package> packages,
      List<int> countPackage);
  Future<List<Teacher>> getTeachers();
  Future<List<City>> getCities();
  Future<List<UserCourses>> getSubscriptions(int userId);
  Future<void> addComment(
      String comment, int userId, Lesson video, int teacherId, String userName);
  Future<List<Course>> getExamCourses(String marhala, int term);
  Future<Exam> getExamsAndCourses(int courseId, int term);
  Future<void> pay(int courseId, int userId);
  Future<void> delAccount(int userId);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final NetworkInfo _networkInfo;
  final Dio _dio;
  RemoteDataSourceImpl(this._networkInfo, this._dio);

  @override
  Future register(String userName, String phone, String password, String grade,
      String group) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}auth/register";
    Response response = await _dio.post(url, data: {
      'name': userName,
      'password': password,
      'phone': phone,
      'grade': grade,
      'group': group,
    });

    if (response.data["message"] == null) {
      throw Exception(AppStrings.previouslyUser);
    }
  }

  @override
  Future<dynamic> logIn(String phone, String password) async {
    await _checkNetwork();
    String url =
        "${Constants.baseUrl}auth/login?&password=$password&phone=$phone";
    final response = await _dio.post(url, data: {
      'password': password,
      'phone': phone,
    });

    final data = response.data;
    if (data["access_token"] == null) {
      throw Exception(AppStrings.wrongPhoneOrPassword);
    }
    if (data["user"]["user_type"] != 'user') {
      throw Exception(AppStrings.notStudent);
    }
    return data;
  }

  @override
  Future<String> getFcmToken() async {
    String? token;
    await FirebaseMessaging.instance.deleteToken().then(
        (value) async => token = await FirebaseMessaging.instance.getToken());
    return token ?? '';
  }

  @override
  void sendTokenAndUserId(int userId) async {
    getFcmToken().then((token) async {
      await _checkNetwork();
      String url =
          "${Constants.baseUrl}mandub/fcm-token?user_id=$userId&token=$token";
      await _dio.patch(url);
    });
  }

  @override
  Future<ClassModel> getRecordedCourses(String marhala) async {
    await _checkNetwork();

    String saff = convertSaffToNum(marhala);
    String url = "${Constants.baseUrl}courses/$saff";
    final response = await _dio.get(url);

    List<Course> courses = [];
    for (var singleCourse in response.data['classroom']) {
      Course course = Course.fromJson(singleCourse);
      courses.add(course);
    }

    return ClassModel(courses, []);
  }

  @override
  Future<List<Wehda>> getTutorials(int courseId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}tutorial/$courseId";
    final response = await _dio.get(url);

    List<Wehda> wehdat = [];
    for (var singleCourse in response.data['tutorial']) {
      Wehda wehda = Wehda.fromJson(singleCourse);
      wehdat.add(wehda);
    }

    return wehdat;
  }

  @override
  Future<String> askQuestion(String question) async {
    await _checkNetwork();
    Future.delayed(const Duration(seconds: 4));
    return Future(() => '');
  }

  _checkNetwork() async {
    if (!await _networkInfo.isConnected) {
      throw Exception(AppStrings.noInternetError);
    }
  }

  @override
  Future<Pair<List<Note>, List<Package>>> getNotes(String marhala) async {
    if (marhala == AppStrings.saff1 ||
        marhala == AppStrings.saff2 ||
        marhala == AppStrings.saff3) {
      return const Pair([], []);
    }
    await _checkNetwork();
    String saff = convertSaffToNum(marhala);

    String url = "${Constants.baseUrl}books/$saff";
    final response = await _dio.get(url);

    List<Note> notes = [];
    List<Package> packages = [];
    for (var singleNote in response.data['package']) {
      Package package = Package.fromJson(singleNote);
      packages.add(package);
    }

    for (var singlePackage in packages) {
      singlePackage.book?.forEach((singleBook) {
        notes.add(singleBook);
      });
    }

    return Pair(notes, packages);
  }

  @override
  Future<Pair<List<Note>, List<Package>>> getAllCart(
      List<String> notesId, List<String> packagesId) async {
    if (notesId.isEmpty && packagesId.isEmpty) return const Pair([], []);

    await _checkNetwork();

    String url = "${Constants.baseUrl}getBooksAndPackage";
    var body = {
      'book_ids': notesId,
      'package_ids': packagesId,
    };
    final response = await _dio.get(url, data: jsonEncode(body));

    List<Note> notes = [];
    List<Package> packages = [];
    for (var singleBook in response.data['books']) {
      Note note = Note.fromJson(singleBook);
      notes.add(note);
    }
    for (var singlePackage in response.data['packages']) {
      Package package = Package.fromJson(singlePackage);
      packages.add(package);
    }
    return Pair(notes, packages);
  }

  @override
  Future<void> order(
      String userName,
      String phone,
      int cityId,
      String address,
      List<Note> notes,
      List<int> count,
      List<Package> packages,
      List<int> countPackage) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}make/order/from/app";

    var items = [];
    int count1 = 0;
    for (var element in notes) {
      items.add({
        'book_id': element.id,
        'package_id': null,
        'quantity': count[count1],
        'price': element.bookPrice,
      });
      count1++;
    }
    count1 = 0;
    for (var element in packages) {
      items.add({
        'book_id': null,
        'package_id': element.id,
        'quantity': countPackage[count1],
        'price': element.price,
      });
      count1++;
    }

    var body = {
      'buyer': userName,
      'phone': phone,
      'address': address,
      'city_id': cityId,
      'items': items,
    };

    await _dio.post(url, data: jsonEncode(body));
  }

  @override
  Future<List<Teacher>> getTeachers() async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}teacher/index";
    var response = await _dio.get(url);
    List<Teacher> teachers =
        TeacherResponse.fromJson(response.data).teacher ?? [];
    return teachers;
  }

  @override
  Future<List<City>> getCities() async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}cities/for/order";
    var response = await _dio.get(url);
    List<City> cities = CityResponse.fromJson(response.data).cities ?? [];
    return cities;
  }

  @override
  Future<List<UserCourses>> getSubscriptions(int userId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}auth/subscription/$userId";
    var response = await _dio.get(url);
    List<UserCourses> userCourses =
        SubscriptionResponse.fromJson(response.data).courses ?? [];
    return userCourses;
  }

  @override
  Future<void> addComment(String comment, int userId, Lesson video,
      int teacherId, String userName) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}video/addComment";

    await _dio.post(
      url,
      data: jsonEncode({
        'video_id': video.id,
        'user_id': userId,
        'comment': comment,
      }),
    );
  }

  @override
  Future<List<Course>> getExamCourses(String marhala, int term) async {
    if (marhala == AppStrings.saff1 ||
        marhala == AppStrings.saff2 ||
        marhala == AppStrings.saff3 ||
        marhala == AppStrings.saff4 ||
        marhala == AppStrings.saff5) {
      return [];
    }
    await _checkNetwork();

    String saff = convertSaffToNum(marhala);
    String url = "${Constants.baseUrl}examClass/$saff/$term";
    var response = await _dio.get(url);
    List<Course> courses = [];
    for (var singleCourse in response.data['classroom']) {
      Course course = Course.fromJson(singleCourse);
      courses.add(course);
    }
    return courses;
  }

  @override
  Future<Exam> getExamsAndCourses(int courseId, int term) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}exam/class/course/term/$courseId/$term";
    var response = await _dio.get(url);
    Exam exam = Exam.fromJson(response.data);
    return exam;
  }

  @override
  Future<void> pay(int courseId, int userId) async {
    await _checkNetwork();

    print('===== PAYING =======');
    // String url = "${Constants.baseUrl}exam";
    // await _dio.post(url);
  }

  @override
  Future<void> delAccount(int userId) async {
    await _checkNetwork();

    await Future.delayed(const Duration(milliseconds: 1500));
  }
}
