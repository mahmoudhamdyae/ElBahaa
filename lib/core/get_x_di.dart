import 'package:dio/dio.dart';
import 'package:elbahaa/data/local/local_data_source.dart';
import 'package:elbahaa/data/remote/remote_data_source.dart';
import 'package:elbahaa/data/repository/repository_impl.dart';
import 'package:elbahaa/domain/repository/repository.dart';
import 'package:elbahaa/presentation/screens/auth/login/controller/login_controller.dart';
import 'package:elbahaa/presentation/screens/auth/register/controller/register_controller.dart';
import 'package:elbahaa/presentation/screens/fav/controller/fav_controller.dart';
import 'package:elbahaa/presentation/screens/home/controller/home_controller.dart';
import 'package:elbahaa/presentation/screens/home/exams/controller/exams_controller.dart';
import 'package:elbahaa/presentation/screens/home/printed_notes/controller/printed_notes_controller.dart';
import 'package:elbahaa/presentation/screens/me/controller/me_controller.dart';
import 'package:elbahaa/presentation/screens/onboarding/controller/onboarding_controller.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network_info.dart';
import '../presentation/screens/auth/auth_controller.dart';
import '../presentation/screens/home/recorded_courses/controller/recorded_courses_controller.dart';
import '../presentation/screens/lesson/controller/lesson_controller.dart';
import '../presentation/screens/subscription/controller/subscription_controller.dart';

class GetXDi implements Bindings {

  @override
  Future<void> dependencies() async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()), fenix: true);
    Get.put<Dio>(dio);

    await Get.putAsync<Box>(() async {
      final Box box = await Hive.openBox('auth');
      return box;
    }, permanent: true);

    await Get.putAsync<SharedPreferences>(() async {
      return await SharedPreferences.getInstance();
    });

    // Data Sources and Repository
    Get.lazyPut<LocalDataSource>(() => LocalDataSourceImpl(Get.find<Box>(), Get.find<SharedPreferences>()), fenix: true);
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl(Get.find<NetworkInfo>(), Get.find<Dio>()), fenix: true);
    Get.lazyPut<Repository>(() => RepositoryImpl(Get.find<RemoteDataSource>(), Get.find<LocalDataSource>()), fenix: true);

    // Controllers
    Get.lazyPut<OnboardingController>(() => OnboardingController(), fenix: true);
    Get.lazyPut<LoginController>(() => LoginController(Get.find<Repository>()), fenix: true);
    Get.lazyPut<RegisterController>(() => RegisterController(Get.find<Repository>()), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(Get.find<Repository>()), fenix: true);
    Get.lazyPut<LessonController>(() => LessonController(Get.find<Repository>()), fenix: true);
    Get.lazyPut<RecordedCoursesController>(() => RecordedCoursesController(Get.find<Repository>()), fenix: true);
    Get.lazyPut<SubscriptionController>(() => SubscriptionController(Get.find<Repository>()), fenix: true);
    Get.lazyPut<FavController>(() => FavController(Get.find<Repository>()), fenix: true);
    Get.put<PrintedNotesController>(PrintedNotesController(Get.find<Repository>()), permanent: true);
    Get.lazyPut<HomeController>(() => HomeController(Get.find<Repository>()), fenix: true);
    Get.lazyPut<ExamsController>(() => ExamsController(Get.find<Repository>()), fenix: true);
    Get.lazyPut<MeController>(() => MeController(Get.find<Repository>()), fenix: true);
    // Get.lazyPut<UpdateProfileController>(() => UpdateProfileController(Get.find<Repository>()), fenix: true);
  }
}