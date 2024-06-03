import 'package:elbahaa/presentation/resources/constants_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:get/get.dart';

import '../presentation/resources/color_manager.dart';
import '../presentation/resources/strings_manager.dart';
import 'constants.dart';

final _flutterMediaDownloaderPlugin = MediaDownload();

void downloadNote(BuildContext context, String link, bool isNote) async {
  if (link != '') {
    String url = '${Constants.baseUrl}filedownload/';
    if (isNote) {
      url += 'books/';
    }
    url += link;
    debugPrint('url: $url');
    Get.showSnackbar(
      const GetSnackBar(
        title: null,
        message: AppStrings.noteDownloading,
        icon: Icon(Icons.download, color: ColorManager.white,),
        duration: Duration(seconds: AppConstants.snackBarTime),
      ),
    );
    _flutterMediaDownloaderPlugin.downloadMedia(context, url).catchError((error) {
      if (Get.isSnackbarOpen) Get.back();
      Get.showSnackbar(
        const GetSnackBar(
          title: null,
          message: AppStrings.noteDownloadError,
          icon: Icon(Icons.error, color: ColorManager.white,),
          duration: Duration(seconds: AppConstants.snackBarTime),
        ),
      );
    }).then((value) {
      if (Get.isSnackbarOpen) Get.back();
      Get.showSnackbar(
        const GetSnackBar(
          title: null,
          message: AppStrings.noteDownloaded,
          icon: Icon(Icons.download_done, color: ColorManager.white,),
          duration: Duration(seconds: AppConstants.snackBarTime),
        ),
      );
    });
  }
}

void downloadExam(BuildContext context, String link) async {
  if (link != '') {
    String url = '${Constants.baseUrl}exam/bank/download/$link';
    debugPrint('url: $url');
    Get.showSnackbar(
      const GetSnackBar(
        title: null,
        message: AppStrings.noteDownloading,
        icon: Icon(Icons.download, color: ColorManager.white,),
        duration: Duration(seconds: AppConstants.snackBarTime),
      ),
    );
    _flutterMediaDownloaderPlugin.downloadMedia(context, url).catchError((error) {
      if (Get.isSnackbarOpen) Get.back();
      Get.showSnackbar(
        const GetSnackBar(
          title: null,
          message: AppStrings.noteDownloadError,
          icon: Icon(Icons.error, color: ColorManager.white,),
          duration: Duration(seconds: AppConstants.snackBarTime),
        ),
      );
    }).then((value) {
      if (Get.isSnackbarOpen) Get.back();
      Get.showSnackbar(
        const GetSnackBar(
          title: null,
          message: AppStrings.examDownloaded,
          icon: Icon(Icons.download_done, color: ColorManager.white,),
          duration: Duration(seconds: AppConstants.snackBarTime),
        ),
      );
    });
  }
}