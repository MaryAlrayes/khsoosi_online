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
      tabs: _navBarsItems(),
      controller: controller,
      avoidBottomPadding: true,
      navBarHeight: 56,
      backgroundColor: ColorManager.black,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      screenTransitionAnimation: ScreenTransitionAnimation(
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
      return _buildBar(
        title: e['title'],
        icon: e['icon'],
        center: e['center'],
        screen: Container(
          child: e['screen'],
        ),
      );
    }).toList();
  }

  PersistentTabConfig _buildBar(
      {required String title,
      required Widget icon,
      bool? center,
      required Widget screen}) {
    return PersistentTabConfig(
      screen: screen,
      item: ItemConfig(
        icon: icon,
        title: title,
        activeForegroundColor: ColorManager.orange1,
        inactiveForegroundColor:
            center != null && center ? Colors.white : Colors.white,
        inactiveBackgroundColor: ColorManager.black,
        activeColorSecondary:
            center != null && center ? Colors.white : ColorManager.orange1,
      ),
    );
  }
}
