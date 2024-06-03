import 'package:elbahaa/domain/models/package.dart';
import 'package:elbahaa/presentation/resources/color_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:elbahaa/presentation/screens/cart/widgets/cart_note_item.dart';
import 'package:elbahaa/presentation/screens/cart/widgets/cart_package_item.dart';
import 'package:elbahaa/presentation/screens/cart/widgets/empty_cart.dart';
import 'package:elbahaa/presentation/screens/cart/widgets/finish_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/insets.dart';
import '../../../../domain/models/notes/note.dart';
import '../../../widgets/error_screen.dart';
import '../../../widgets/loading_screen.dart';
import '../../../widgets/top_bar.dart';
import '../../home/printed_notes/controller/printed_notes_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const TopBar(title: AppStrings.cart,),
          GetX<PrintedNotesController>(
            init: Get.find<PrintedNotesController>(),
            builder: (PrintedNotesController controller) {
              List<Note> notes = controller.cartNotes;
              List<Package> packages = controller.cartPackages;
              if (controller.status.isLoading) {
                return const LoadingScreen();
              } else if (controller.status.isError) {
                return ErrorScreen(error: controller.status.errorMessage ?? '');
              } else if (controller.cartNotes.isEmpty && controller.cartPackages.isEmpty){
                return const EmptyCart(emptyString: AppStrings.noCart);
              }
              return isWide(context) ?
              _buildTwoColumn(context, controller, packages, notes)
                  :
              _buildOneColumn(context, controller, packages, notes);
            },
          )
        ],
      ),
    );
  }

  Widget _buildOneColumn(BuildContext context, PrintedNotesController controller, List<Package> packages, List<Note> notes) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        _buildHeader(controller),
        // اتمام عملية الشراء
        _buildBuyButton(context),
        _buildBooksAndPackages(controller, packages, notes),
      ],
    );
  }

  Widget _buildTwoColumn(BuildContext context, PrintedNotesController controller, List<Package> packages, List<Note> notes) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              _buildHeader(controller),
              // اتمام عملية الشراء
              _buildBuyButton(context),
            ],
          ),
        ),
        const SizedBox(width: 16.0,),
        Expanded(
            flex: 3,
            child: _buildBooksAndPackages(controller, packages, notes),
        ),
      ],
    );
  }

  Widget _buildBooksAndPackages(PrintedNotesController controller, List<Package> packages, List<Note> notes) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        controller.cartPackages.isEmpty ? Container() : _buildPackagesList(packages),
        controller.cartNotes.isEmpty ? Container() : _buildNotesList(notes),
      ],
    );
  }

  Padding _buildBuyButton(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    style: getFilledButtonStyle(),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: ColorManager.white,
                          title: Text(
                            AppStrings.orderDetails,
                            style: getLargeStyle(),
                          ),
                          content: const FinishOrderScreen(),
                        );
                      });
                    },
                    child: const Text(AppStrings.finishOrder),
                  ),
                );
  }

  Padding _buildHeader(PrintedNotesController controller) {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 8.0),
                  child: Column(
                    children: [
                      // الإجمالى
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.sum,
                            style: getLargeStyle(),
                          ),
                          Text(
                            '${controller.sum} د.ك',
                            style: getSmallStyle(),
                          ),
                        ],
                      ),
                      // الخصم
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.discount,
                            style: getLargeStyle(),
                          ),
                          Text(
                            '- ${controller.discount} د.ك',
                            style: getSmallStyle(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0,),
                      const Divider(height: 1, color: ColorManager.primaryTransparent,),
                      const SizedBox(height: 8.0,),
                      // المحموع الكلى
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.total,
                            style: getLargeStyle(),
                          ),
                          Text(
                            '${controller.totalSum} د.ك',
                            style: getSmallStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
  }

  Widget _buildPackagesList(List<Package> packages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            AppStrings.cartPackages,
            style: getLargeStyle(),
          ),
        ),
        ListView.builder(
          itemCount: packages.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0,
          ),

          itemBuilder: (BuildContext context, int index) {
            return CartPackageItem(package: packages[index], index: index);
          },
        ),
      ],
    );
  }

  Widget _buildNotesList(List<Note> notes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            AppStrings.cartNotes,
            style: getLargeStyle(),
          ),
        ),
        ListView.builder(
          itemCount: notes.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0,
          ),

          itemBuilder: (BuildContext context, int index) {
            return CartNoteItem(note: notes[index], index: index);
          },
        ),
      ],
    );
  }
}
