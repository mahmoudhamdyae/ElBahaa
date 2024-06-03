// import 'package:elbahaa/presentation/resources/color_manager.dart';
// import 'package:elbahaa/presentation/resources/styles_manager.dart';
// import 'package:elbahaa/presentation/screens/update_profile/controller/update_profile_controller.dart';
// import 'package:elbahaa/presentation/widgets/error_screen.dart';
// import 'package:elbahaa/presentation/widgets/loading_screen.dart';
// import 'package:elbahaa/presentation/widgets/top_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// import '../../../resources/constants_manager.dart';
// import '../../../resources/font_manager.dart';
// import '../../../resources/strings_manager.dart';
// import '../../../resources/values_manager.dart';
// import '../../../widgets/dialogs/error_dialog.dart';
// import '../../../widgets/dialogs/loading_dialog.dart';
//
// class UpdateProfileScreen extends StatefulWidget {
//   const UpdateProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
// }
//
// class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
//
//   GlobalKey<FormState> formState = GlobalKey<FormState>();
//
//   _updateProfileData() async {
//     var formData = formState.currentState;
//     if (formData!.validate()) {
//       formData.save();
//       TextInput.finishAutofillContext();
//       showLoading(context);
//       final UpdateProfileController controller = Get.find<UpdateProfileController>();
//       controller.updateProfileData().then((value) {
//         if (controller.updateStatus.isError) {
//           Get.back();
//           showError(context, controller.updateStatus.errorMessage.toString(), () {});
//         } else {
//           Get.back();
//           Get.back();
//           Get.showSnackbar(
//             const GetSnackBar(
//               title: null,
//               message: AppStrings.updatedSuccessfully,
//               duration: Duration(seconds: AppConstants.snackBarTime),
//             ),
//           );
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetX<UpdateProfileController>(
//         init: Get.find<UpdateProfileController>(),
//         builder: (UpdateProfileController controller) {
//           return _buildOneColumn(controller);
//         },
//       ),
//     );
//   }
//
//   ListView _buildOneColumn(UpdateProfileController controller) {
//     return ListView(
//       children: [
//         _buildTopBar(),
//         _buildForm(controller),
//       ],
//     );
//   }
//
//   Widget _buildForm(UpdateProfileController controller) {
//     if (controller.getDataStatus.isLoading) {
//       return const LoadingScreen();
//     } else if (controller.getDataStatus.isError) {
//       return ErrorScreen(error: controller.getDataStatus.errorMessage ?? '');
//     }
//     return Form(
//       key: formState,
//       child: Padding(
//         padding: const EdgeInsets.all(AppPadding.p20),
//         child: AutofillGroup(
//           child: Column(
//             children: [
//               // User Name Edit Text
//               TextFormField(
//                 controller: controller.userName,
//                 textInputAction: TextInputAction.next,
//                 keyboardType: TextInputType.text,
//                 validator: (val) {
//                   if (val.toString().isNotEmpty) {
//                     return null;
//                   }
//                   return AppStrings.userNameInvalid;
//                 },
//
//                 style: getLargeStyle(
//                   fontSize: FontSize.s14,
//                   color: ColorManager.grey,
//                 ),
//                 decoration: getTextFieldDecoration(
//                   hint: AppStrings.usernameHint,
//                   onPressed: () { },
//                   prefixIcon: Icons.person_outline_outlined,
//                 ),
//               ),
//               const SizedBox(
//                 height: AppSize.s28,
//               ),
//               // Phone Number Edit Text
//               TextFormField(
//                 autofillHints: const [AutofillHints.email],
//                 controller: controller.phone,
//                 textInputAction: TextInputAction.next,
//                 keyboardType: TextInputType.phone,
//                 validator: (val) {
//                   if (val.toString().isNotEmpty) {
//                     return null;
//                   }
//                   return AppStrings.mobileNumberInvalid;
//                 },
//
//                 style: getLargeStyle(
//                   fontSize: FontSize.s14,
//                   color: ColorManager.grey,
//                 ),
//                 decoration: getTextFieldDecoration(
//                   hint: AppStrings.phoneHint,
//                   onPressed: () { },
//                   prefixIcon: Icons.phone_android,
//                 ),
//               ),
//               const SizedBox(
//                 height: AppSize.s28,
//               ),
//               // Email Edit Text
//               TextFormField(
//                 controller: controller.email,
//                 textInputAction: TextInputAction.next,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (val) {
//                   if (val.toString().isNotEmpty) {
//                     return null;
//                   }
//                   return AppStrings.emailInvalid;
//                 },
//
//                 style: getLargeStyle(
//                   fontSize: FontSize.s14,
//                   color: ColorManager.grey,
//                 ),
//                 decoration: getTextFieldDecoration(
//                   hint: AppStrings.emailHint,
//                   onPressed: () { },
//                   prefixIcon: Icons.email,
//                 ),
//               ),
//               const SizedBox(
//                 height: AppSize.s28,
//               ),
//               // Password Edit Text
//               TextFormField(
//                 autofillHints: const [AutofillHints.password],
//                 controller: controller.password,
//                 textInputAction: TextInputAction.done,
//                 validator: (val) {
//                   if (val == null || val.isEmpty) {
//                     return AppStrings.passwordInvalid;
//                   }
//                   return null;
//                 },
//                 obscureText: controller.obscureText.value,
//                 style: getLargeStyle(
//                   fontSize: FontSize.s14,
//                   color: ColorManager.grey,
//                 ),
//                 decoration: getTextFieldDecoration(
//                     hint: AppStrings.passwordHint,
//                     onPressed: () {
//                       controller.toggleSecurePassword();
//                     },
//                     prefixIcon: Icons.lock_outline,
//                     suffixIcon: controller.obscureText.value
//                         ? Icons.visibility
//                         : Icons.visibility_off
//                 ),
//               ),
//               const SizedBox(
//                 height: AppSize.s28,
//               ),
//               // Login Button
//               SizedBox(
//                 width: double.infinity,
//                 height: AppSize.s40,
//                 child: FilledButton(
//                   style: getFilledButtonStyle(),
//                   onPressed: () async {
//                     await _updateProfileData();
//                   },
//                   child: Text(
//                     AppStrings.updateProfileButton,
//                     style: getSmallStyle(
//                         color: ColorManager.white
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTopBar() {
//     return const TopBar(title: AppStrings.updateTopBar,);
//   }
// }
