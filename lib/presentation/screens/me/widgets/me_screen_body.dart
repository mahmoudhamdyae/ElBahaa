import 'package:elbahaa/core/utils/insets.dart';
import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/screens/auth/auth_controller.dart';
import 'package:elbahaa/presentation/screens/home/widgets/home_app_bar/user_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MeScreenBody extends StatelessWidget {

  final List<Widget> meWidgets;
  const MeScreenBody({super.key, required this.meWidgets});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildTopBar(),
        _buildProfileHeader(),
        _buildDivider(),
        isWide(context) ? _buildMeGrid(context) : _buildMeList(context),
        const SizedBox(height: 64.0,),
      ],
    );
  }

  Padding _buildDivider() {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Divider(color: Color(0xffE4E4E4),),
      );
  }

  Padding _buildProfileHeader() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            const UserImage(),
            const SizedBox(width: 8.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Get.find<AuthController>().getUserName(),
                  style: getLargeStyle(
                    color: ColorManager.secondary
                  ),
                ),
                Text(
                  Get.find<AuthController>().getPhoneNumber(),
                  style: getSmallStyle(),
                ),
              ],
            )
          ],
        ),
      );
  }

  Center _buildTopBar() {
    return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            AppStrings.bottomBarMe,
            style: getLargeStyle(),
          ),
        ),
      );
  }

  Widget _buildMeList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: meWidgets.length,
      itemBuilder: (BuildContext context, int index) {
        return meWidgets[index];
      },
    );
  }

  Widget _buildMeGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      childAspectRatio: 6.0,
      crossAxisCount: 2,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: List.generate(meWidgets.length, (index) {
        return meWidgets[index];
      }),
    );
  }
}
