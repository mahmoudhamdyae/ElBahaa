import 'package:elbahaa/presentation/resources/assets_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/screens/fav/widgets/fav_screen.dart';
import 'package:elbahaa/presentation/screens/me/widgets/me_screen.dart';
import 'package:elbahaa/presentation/screens/subscription/widgets/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rate_my_app/rate_my_app.dart';
import '../../core/check_version.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';
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

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const SubscriptionScreen(),
      const FavScreen(),
      const MeScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 0;
            _controller.index = 0;
          });
        },
        icon: _selectedIndex == 0 ? SvgPicture.asset(ImageAssets.homeSelected,) : SvgPicture.asset(ImageAssets.home,),
        title: AppStrings.bottomBarHome,
        activeColorPrimary: ColorManager.white,
      ),
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 1;
            _controller.index = 1;
          });
        },
        icon: _selectedIndex == 1 ? SvgPicture.asset(ImageAssets.subscriptionSelected,) : SvgPicture.asset(ImageAssets.subscription,),
        title: AppStrings.bottomBarSubscription,
        activeColorPrimary: ColorManager.white,
      ),
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 2;
            _controller.index = 2;
          });
        },
        icon: _selectedIndex == 2 ? SvgPicture.asset(ImageAssets.favSelected,) : SvgPicture.asset(ImageAssets.fav,),
        title: AppStrings.bottomBarCart,
        activeColorPrimary: ColorManager.white,
      ),
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 3;
            _controller.index = 3;
          });
        },
        icon: _selectedIndex == 3 ? SvgPicture.asset(ImageAssets.meSelected,) : SvgPicture.asset(ImageAssets.me,),
        title: AppStrings.bottomBarMe,
        activeColorPrimary: ColorManager.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        // backgroundColor: ColorManager.primary,
        decoration: const NavBarDecoration(
          colorBehindNavBar: ColorManager.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 12, spreadRadius: 4),
          ],
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: AppConstants.sliderAnimationTime),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: AppConstants.sliderAnimationTime),
        ),
        navBarStyle: NavBarStyle.style13, // Choose the nav bar style with this property.
      ),
    );
  }
}
