import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../screens/welcome_screen.dart';
import '../screens/tours_screen.dart';
import '../screens/map_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/checklist_screen.dart';
import '../theme/app_colors.dart';

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
        activeColorPrimary: AppColors.goldPrimary,
        inactiveColorPrimary: AppColors.textTertiary,
        activeColorSecondary: AppColors.goldPrimary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.location_solid),
        title: "Places",
        activeColorPrimary: AppColors.goldPrimary,
        inactiveColorPrimary: AppColors.textTertiary,
        activeColorSecondary: AppColors.goldPrimary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.checkmark_circle),
        title: "Checklist",
        activeColorPrimary: AppColors.goldPrimary,
        inactiveColorPrimary: AppColors.textTertiary,
        activeColorSecondary: AppColors.goldPrimary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.map),
        title: "Map",
        activeColorPrimary: AppColors.goldPrimary,
        inactiveColorPrimary: AppColors.textTertiary,
        activeColorSecondary: AppColors.goldPrimary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: "Profile",
        activeColorPrimary: AppColors.goldPrimary,
        inactiveColorPrimary: AppColors.textTertiary,
        activeColorSecondary: AppColors.goldPrimary,
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
      navBarStyle: NavBarStyle.style9,
      backgroundColor: AppColors.secondaryBg,
      decoration: NavBarDecoration(
        border: Border(top: BorderSide(color: AppColors.goldSecondary.withValues(alpha: 0.3), width: 1)),
      ),
    );
  }
}
