import 'package:elbahaa/presentation/screens/auth/auth_controller.dart';
import 'package:elbahaa/presentation/screens/me/widgets/dialogs/del_acccount_dialog.dart';
import 'package:elbahaa/presentation/screens/me/widgets/me_screen_body.dart';
import 'package:elbahaa/presentation/screens/me/widgets/dialogs/sign_out_dialog.dart';
import 'package:elbahaa/presentation/widgets/require_log_in_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../widgets/dialogs/soon_dialog.dart';
import '../../main_screen.dart';
import 'me_item.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Get.find<AuthController>().isUserLoggedIn() ?
      MeScreenBody(meWidgets: [
        MeItem(
          icon: ImageAssets.editProfile,
          title: AppStrings.editProfile,
          action: () {
            showSoonDialog(context);
          },
        ),
        MeItem(
          icon: ImageAssets.baqat,
          title: AppStrings.baqat,
          action: () {
            Get.offAll(() => const MainScreen(selectedIndex: 1,));
          },
        ),
        MeItem(
          icon: ImageAssets.helpCenter,
          title: AppStrings.helpCenter,
          action: () => showSoonDialog(context),
        ),
        MeItem(
          icon: ImageAssets.whoAreWe,
          title: AppStrings.whoAreWe,
          action: () => showSoonDialog(context),
        ),
        MeItem(
          icon: ImageAssets.delAccount,
          title: AppStrings.delAccount,
          action: () => showDelAccountDialog(context),
        ),
        MeItem(
            icon: ImageAssets.signOut,
            title: AppStrings.signOut,
            action: () => showSignOutDialog(context)
        ),
      ],) :
      const RequireLogInView();
  }
}
