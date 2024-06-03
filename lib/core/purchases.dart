import 'package:elbahaa/core/converters.dart';
import 'package:elbahaa/domain/models/courses/course.dart';
import 'package:elbahaa/domain/repository/repository.dart';
import 'package:elbahaa/presentation/screens/auth/auth_controller.dart';
import 'package:elbahaa/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../presentation/resources/constants_manager.dart';
import '../presentation/resources/strings_manager.dart';
import 'constants.dart';
import 'launch_site.dart';

Future<void> purchase(
    BuildContext context,
    Course course,
    bool isMonth,
    ) async {
  GetPlatform.isAndroid ? launchSite(Constants.siteUrl)
      :
  _purchaseIos(context, course, isMonth);
}

Future<void> _purchaseIos(
    BuildContext context,
    Course course,
    bool isMonth,
    ) async {
  if (Get.find<AuthController>().isUserLoggedIn()) {
    showLoading(context);
    List<StoreProduct> productList =
    await Purchases.getProducts([_getPurchaseId(
      course.marhala,
      course.name,
      isMonth,
      isMonth ? course.month.toString() : course.term.toString(),
    )]);
    bool isError = false;
    await Purchases.purchaseStoreProduct(productList.first)
        .then((value) {
      debugPrint("======= SUCCEEDED then $value");
    }).whenComplete(() {
      debugPrint("======= COMPLETE");
    }).catchError((error) {
      isError = true;
      debugPrint("======= ERROR $error");
    });
    debugPrint("======= after");
    if (!isError) {
      Get.find<Repository>().pay(course.id);
    }
    Get.back();
  } else {
    Get.showSnackbar(
      const GetSnackBar(
        title: null,
        message: AppStrings.requireLog,
        duration: Duration(seconds: AppConstants.snackBarTime),
      ),
    );
  }
}

String _getPurchaseId(
    String grade,
    String courseName,
    bool isMonth,
    String price
    ) {
  String saff = convertSaffToNum(grade);
  String subscription = isMonth ? 'month' : 'term';
  String purchaseId = '${saff}_${_convertCourseName(courseName)}_${subscription}_$price';
  debugPrint('Purchase Id: $purchaseId');
  return purchaseId;
}

String _convertCourseName(String oldName) {
  switch(oldName) {
    case 'الرياضيات':
      return 'math';
    case 'العلوم':
      return 'science';
    case 'اللغة العربية':
      return 'arabic';
    case 'اللغة الانجليزية':
      return 'english';
    case 'الاجتماعيات':
      return 'social';
    case 'الكيمياء':
      return 'chemistry';
    case 'الفيزياء':
      return 'physics';
    case 'التاريخ':
      return 'history';
    case 'الأحياء':
      return 'biology';
    case 'الجيولوجيا':
      return 'geology';
    case 'الجغرافيا':
      return 'geography';
    case 'علم النفس':
      return 'psychology';
    case 'اللغة الفرنسية':
      return 'french';
    case 'الإحصاء':
      return 'statistics';
    case 'الفلسفة':
      return 'philosophy';
    default:
      return '';
  }
}