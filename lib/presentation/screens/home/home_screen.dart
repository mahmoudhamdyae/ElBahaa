import 'package:elbahaa/domain/models/slider.dart';
import 'package:elbahaa/presentation/resources/assets_manager.dart';
import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/screens/home/controller/home_controller.dart';
import 'package:elbahaa/presentation/screens/home/widgets/home_app_bar/home_app_bar.dart';
import 'package:elbahaa/presentation/screens/home/widgets/swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../domain/models/home_ui.dart';
import '../../widgets/custom_grid_view.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            HomeAppBar(),
            // isWide(context) ? _buildTwoColumn(context)
            //     :
            _buildOneColumn(context),
          ],
        )
    );
  }

  ScreenUtilInit _buildOneColumn(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Stack(
                children: [
                  Image.asset(
                    ImageAssets.youngManBackground,
                    height: 160.h,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    left: -80,
                    top: 0,
                    bottom: 0,
                    child: Image.asset(
                      ImageAssets.youngMan,
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.mainTitle,
                              textAlign: TextAlign.center,
                              style: getLargeStyle(
                                  color: ColorManager.secondary,
                                  fontSize: 16.sp
                              ),
                            ),
                            SizedBox(height: 16.h,),
                            Text(
                              AppStrings.mainDesc1,
                              textAlign: TextAlign.start,
                              style: getSmallStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 16.h,),
                            Text(
                              AppStrings.mainDesc2,
                              textAlign: TextAlign.start,
                              style: getSmallStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomGridView(HomeUI.getItems(context)),
            // _buildPackagesAndTeachers(),
          ],
        );
      },
    );
  }

  Widget _buildTwoColumn(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
            child: CustomGridView(HomeUI.getItems(context)),
        ),
        const SizedBox(width: 16.0,),
        // Expanded(
        //     flex: 1,
        //     child: _buildPackagesAndTeachers(),
        // ),
      ],
    );
  }

  Widget _buildPackagesAndTeachers() {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        GetPlatform.isAndroid ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            AppStrings.baqat3,
            style: getLargeStyle(),
          ),
        ) : Container(),
        GetPlatform.isAndroid ?
        SwiperWidget(sliders: SliderModel.getBaqat(), isTeacher: false,)
        :
        Container(),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 16.0),
          child: GetX<HomeController>(
            init: Get.find<HomeController>(),
            builder: (HomeController controller) {
              return Text(
                controller.teachers.isEmpty ? '' : AppStrings.teachers,
                style: getLargeStyle(),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: GetX<HomeController>(
            init: Get.find<HomeController>(),
            builder: (HomeController controller) {
              return SwiperWidget(
                sliders: SliderModel.getTeachers(controller.teachers),
                isTeacher: true,
              );},
          ),
        )
      ],
    );
  }
}
