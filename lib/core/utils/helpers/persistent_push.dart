import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

pushScreen( {required BuildContext context, required Widget screen}) {
  PersistentNavBarNavigator.pushNewScreen(
    context,
    screen: screen,
    withNavBar: false,
    pageTransitionAnimation: PageTransitionAnimation.slideUp,
  );
}
