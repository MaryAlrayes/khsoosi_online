import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
barPushScreen( {required BuildContext context, required Widget screen}) {
  pushScreen (
    context,
    screen: screen,
    withNavBar: false,
    pageTransitionAnimation: PageTransitionAnimation.slideUp,

  );
}
