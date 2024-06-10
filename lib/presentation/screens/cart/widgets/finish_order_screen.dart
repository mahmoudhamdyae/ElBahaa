import 'package:elbahaa/presentation/screens/home/printed_notes/controller/printed_notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/constants_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../widgets/dialogs/error_dialog.dart';
import '../../../widgets/dialogs/loading_dialog.dart';
import '../../main_screen.dart';

class FinishOrderScreen extends StatefulWidget {
  const FinishOrderScreen({super.key});

  @override
  State<FinishOrderScreen> createState() => _FinishOrderScreenState();
}

class _FinishOrderScreenState extends State<FinishOrderScreen> {

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  _order() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      final PrintedNotesController controller = Get.find<PrintedNotesController>();

      // if (controller.selectedArea.value == controller.areas.first) {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(AppStrings.areaInvalid)));
      //   return;
      // }

      showLoading(context);
      await controller.order().then((value) {
        showLoading(context);
        if (controller.status.isError) {
          Get.back();
          showError(context, controller.status.errorMessage.toString(), () {});
        } else {
          Get.offAll(() => const MainScreen(selectedIndex: 0,));
          Get.showSnackbar(
            const GetSnackBar(
              title: null,
              message: AppStrings.successDialogTitle,
              icon: Icon(Icons.download_done, color: ColorManager.white,),
              duration: Duration(seconds: AppConstants.snackBarTime),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formState,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0,),
              // User Name Edit Text
              TextFormField(
                controller: Get.find<PrintedNotesController>().userName,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return AppStrings.userNameInvalid;
                  }
                  return null;
                },
                style: getLargeStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.grey,
                ),
                decoration: getTextFieldDecoration(
                  hint: AppStrings.usernameHint,
                  prefixIcon: null,
                  onPressed: () { },
                  suffixIcon: Icons.person_outline_outlined,
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              // Phone Number Edit Text
              TextFormField(
                controller: Get.find<PrintedNotesController>().phone,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val.toString().isNotEmpty) {
                    return null;
                  }
                  return AppStrings.mobileNumberInvalid;
                },
                style: getLargeStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.grey,
                ),
                decoration: getTextFieldDecoration(
                  hint: AppStrings.phoneHint,
                  prefixIcon: null,
                  onPressed: () {},
                  suffixIcon: Icons.phone_android,
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              // Register Button
              SizedBox(
                width: double.infinity,
                height: AppSize.s40,
                child: FilledButton(
                  style: getFilledButtonStyle(),
                  onPressed: () async {
                    await _order();
                  },
                  child: const Text(
                    AppStrings.confirmOrder,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
