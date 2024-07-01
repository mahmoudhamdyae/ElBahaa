import 'package:elbahaa/presentation/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';

import '../../core/utils/insets.dart';
import '../../domain/models/home_ui.dart';
import 'grid_view_item.dart';

class CustomGridView extends StatelessWidget {

  final List<HomeUI> _items;
  const CustomGridView(this._items, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      crossAxisCount: isWide(context) ? 4 : 2,//(MediaQuery.of(context).size.width ~/ 160).toInt(),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: (MediaQuery.of(context).size.width / 2) / (MediaQuery.of(context).size.height / 4),
      children: [
        GridViewItem(item: _items[0]),
        GridViewItem(item: _items[1]),
        GridViewItem(item: _items[2]),
        GridViewItem(item: _items[3]),
      ],
    );
  }
}
