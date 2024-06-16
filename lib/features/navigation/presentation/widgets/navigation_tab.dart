// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class NavigationTab extends StatelessWidget {
  final PersistentTabController controller;

  final List<Map<String, dynamic>> items;

  const NavigationTab({
    Key? key,
    required this.controller,

    required this.items,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs:  _navBarsItems(),

      // context,
      controller: controller,
      // screens: screens,
      // items: _navBarsItems(),
      // confineInSafeArea: true,
      backgroundColor: ColorManager.black, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      // hideNavigationBarWhenKeyboardShows:
      //     true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      // decoration: NavBarDecoration(
      //   borderRadius: BorderRadius.circular(0),
      //   colorBehindNavBar: ColorManager.black,
      // ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,

      // itemAnimationProperties: ItemAnimationProperties(
      //   // Navigation Bar's items animation properties.
      //   duration: Duration(milliseconds: 200),
      //   curve: Curves.ease,
      // ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        // animateTabTransition: true,

        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
       navBarBuilder: (navBarConfig) => Style13BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(color: ColorManager.black),
        ),
        onTabChanged: (value) {
        // if (onSelected != null) onSelected!(value);
      },

    );
  }

  List<PersistentTabConfig> _navBarsItems() {
    return items.map((e) {
      return _buildBar(title: e['title'], icon: e['icon'], center: e['center'],screen: e['screen']);
    }).toList();
  }

  PersistentTabConfig _buildBar(
      {required String title,
      required Icon icon,
      bool? center,
      required Widget screen}) {
    return PersistentTabConfig(
        screen: screen,
        item: ItemConfig(
            icon: icon,
            title: title,

            // activeColorPrimary: ColorManager.orange1,
            // inactiveColorPrimary: Colors.white,
            // inactiveColorSecondary:
            // center != null && center ? Colors.white : Colors.white,
            activeForegroundColor: ColorManager.orange1,
            inactiveForegroundColor:
                center != null && center ? Colors.white : Colors.white,
            inactiveBackgroundColor: ColorManager.black,

            activeColorSecondary: center != null && center
                ? Colors.white
                : ColorManager.orange1));
  }
}
