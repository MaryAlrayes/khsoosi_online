// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';

class NavigationTab extends StatelessWidget {
  final PersistentTabController controller;
  final  List<Widget> screens;
  final List<Map<String,dynamic>> items;
  final Function? onSelected;
  const NavigationTab({
    Key? key,
    required this.controller,
    required this.screens,
    required this.items,
     this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: screens,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: ColorManager.black, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0),
        colorBehindNavBar: ColorManager.black,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15,
        onItemSelected: (value) {
       if(onSelected!=null)  onSelected!(value);
            },
    );
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return items.map((e) {
   return _buildBar(title: e['title'], icon: e['icon'],center: e['center']);
    }).toList();

  }

    PersistentBottomNavBarItem _buildBar(
      {required String title, required Icon icon, bool? center}) {
    return PersistentBottomNavBarItem(
        icon: icon,
        title: title,
        activeColorPrimary: ColorManager.orange1,
        inactiveColorPrimary: Colors.white,
        inactiveColorSecondary:
            center != null && center ? Colors.white : Colors.white,
        activeColorSecondary:
            center != null && center ? Colors.white : ColorManager.orange1);
  }
}
