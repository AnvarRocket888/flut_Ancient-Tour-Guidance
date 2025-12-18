import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../screens/welcome_screen.dart';
import '../screens/tours_screen.dart';
import '../screens/map_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/checklist_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const WelcomeScreen(),
      const PlacesScreen(),
      const ChecklistScreen(),
      const MapScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: "Home",
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: const Color(0xFF9E9E9E),
        activeColorSecondary: const Color(0xFF1C1C24),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.location_solid),
        title: "Places",
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: const Color(0xFF9E9E9E),
        activeColorSecondary: const Color(0xFF1C1C24),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.checkmark_circle),
        title: "Checklist",
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: const Color(0xFF9E9E9E),
        activeColorSecondary: const Color(0xFF1C1C24),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.map),
        title: "Map",
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: const Color(0xFF9E9E9E),
        activeColorSecondary: const Color(0xFF1C1C24),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: "Profile",
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: const Color(0xFF9E9E9E),
        activeColorSecondary: const Color(0xFF1C1C24),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: const Color(0xFF232332),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      padding: const EdgeInsets.only(top: 8),
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: 60,
      navBarStyle: NavBarStyle.style1,
    );
  }
}
