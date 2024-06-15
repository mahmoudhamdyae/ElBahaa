import 'package:elbahaa/presentation/resources/assets_manager.dart';
import 'package:elbahaa/presentation/screens/fav/widgets/fav_screen.dart';
import 'package:elbahaa/presentation/screens/me/widgets/me_screen.dart';
import 'package:elbahaa/presentation/screens/subscription/widgets/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:rate_my_app/rate_my_app.dart';
import '../../core/check_version.dart';
import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {

  final int selectedIndex;
  final RateMyApp? rateMyApp;
  const MainScreen({super.key, required this.selectedIndex, this.rateMyApp});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late PersistentTabController _controller;
  late int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    debugPrint('Selected Tab Index $_selectedIndex');
    _controller = PersistentTabController(initialIndex: _selectedIndex);
    try {
      versionCheck(context, () {
        if (widget.rateMyApp != null && widget.rateMyApp!.shouldOpenDialog) {
          widget.rateMyApp?.showRateDialog(
            context,
            title: 'قيم هذا التطبيق',
            message: 'إذا أعجبك هذا التطبيق ، خصص القليل من وقتك لتقييمه',
            rateButton: 'قيم الآن',
            noButton: 'لا شكرا',
            laterButton: 'ذكرنى لاحقا',
          );
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        controller: _controller,
        onTabChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        tabs: [
          PersistentTabConfig(
            screen: const HomeScreen(),
            item: ItemConfig(
                icon: SvgPicture.asset(ImageAssets.homeSelected,),
                title: null,
                inactiveIcon: SvgPicture.asset(ImageAssets.home,)
            ),
          ),
          PersistentTabConfig(
            screen: const SubscriptionScreen(),
            item: ItemConfig(
                icon: SvgPicture.asset(ImageAssets.subscriptionSelected,),
                title: null,
                inactiveIcon: SvgPicture.asset(ImageAssets.subscription,)
            ),
          ),
          PersistentTabConfig(
            screen: const FavScreen(),
            item: ItemConfig(
                icon: SvgPicture.asset(ImageAssets.favSelected,),
                title: null,
                inactiveIcon: SvgPicture.asset(ImageAssets.fav,)
            ),
          ),
          PersistentTabConfig(
            screen: const MeScreen(),
            item: ItemConfig(
                icon: SvgPicture.asset(ImageAssets.meSelected,),
                title: null,
                inactiveIcon: SvgPicture.asset(ImageAssets.me,)
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: const NavBarDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.0),
                topLeft: Radius.circular(16.0),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 12, spreadRadius: 4),
            ],
          ),
        ),
      ),
    );
  }
}
