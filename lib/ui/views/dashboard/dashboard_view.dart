import 'package:flutter/material.dart';
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";
import 'package:qrapp/ui/views/dashboard/dashboard_view_model.dart';
import 'package:qrapp/ui/views/profile/profile_view.dart';

import '../admin_home/admin_home_view.dart';
import '../admin_qr/adminqr_view.dart';
import '../admin_qr_history/admin_qr_history_view.dart';
import '../base_view.dart';
import '../history/history_view.dart';

class DashboardView extends StatelessWidget {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  final String role;
  DashboardView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      onModelReady: (model) async {},
      builder: (context, model, child) => PersistentTabView(
        context,
        controller: controller,
        screens: role == 'user' ? _buildScreensUser() : _buildScreensAdmin(),
        items: role == 'user' ? _navBarsItemsUser() : _navBarsItemsAdmin(),
        resizeToAvoidBottomInset: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        selectedTabScreenContext: (final context) {},
        decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle:
            NavBarStyle.style5, // Choose the nav bar style with this property
      ),
    );
  }

  List<Widget> _buildScreensUser() {
    return [
      HistoryView(),
      ProfileView(
        isBottom: true,
      ),
      // Container(),
    ];
  }

  List<Widget> _buildScreensAdmin() {
    return [
      AdminHomeView(),
      AdminQrHistoryView(),
      ProfileView(
        isBottom: true,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItemsUser() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.camera,
          color: Colors.purple,
        ),
        inactiveIcon: const Icon(
          Icons.camera,
          color: Colors.grey,
        ),
        activeColorPrimary: Colors.purple,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.person,
          color: Colors.purple,
        ),
        inactiveIcon: const Icon(
          Icons.person,
          color: Colors.grey,
        ),
        activeColorPrimary: Colors.purple,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItemsAdmin() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.admin_panel_settings,
          color: Colors.purple,
        ),
        inactiveIcon: const Icon(
          Icons.admin_panel_settings,
          color: Colors.grey,
        ),
        activeColorPrimary: Colors.purple,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.qr_code,
          color: Colors.purple,
        ),
        inactiveIcon: const Icon(
          Icons.qr_code,
          color: Colors.grey,
        ),
        activeColorPrimary: Colors.purple,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.person,
          color: Colors.purple,
        ),
        inactiveIcon: const Icon(
          Icons.person,
          color: Colors.grey,
        ),
        activeColorPrimary: Colors.purple,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
