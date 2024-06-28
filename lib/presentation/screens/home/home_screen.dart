import 'package:elbahaa/domain/models/slider.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/screens/home/controller/home_controller.dart';
import 'package:elbahaa/presentation/screens/home/widgets/home_app_bar/home_app_bar.dart';
import 'package:elbahaa/presentation/screens/home/widgets/swiper.dart';
import 'package:flutter/material.dart';
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

  ListView _buildOneColumn(BuildContext context) {
    return ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.mainTitle,
                      style: getLargeStyle(),
                    ),
                    const SizedBox(height: 8.0,),
                    Text(
                      AppStrings.mainDesc,
                      textAlign: TextAlign.center,
                      style: getSmallStyle(),
                    ),
                  ],
                ),
              ),
              CustomGridView(HomeUI.getItems(context)),
              // _buildPackagesAndTeachers(),
            ],
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
