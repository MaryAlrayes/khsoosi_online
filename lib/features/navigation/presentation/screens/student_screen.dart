import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/assistence_screen.dart';
import 'package:khosousi_online/features/messages/presentation/pages/inbox_messages_screen.dart';
import 'package:khosousi_online/features/navigation/presentation/widgets/navigation_tab.dart';
import 'package:khosousi_online/features/notification/presentation/pages/notification_screen.dart';
import 'package:khosousi_online/features/search/presentation/search/screens/search_screen.dart';
import 'package:khosousi_online/features/student_account/presentation/pages/student_account.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class StudentScreen extends StatelessWidget {
  static const routeName = 'student_screen';
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);

  List<Widget> _buildScreens() {
    return [
      AssistenceScreen(),
      InboxMessagesScreen(),
      SearchScreen(),
      NotificationScreen(),
      StudentAccount(),
    ];
  }

  List<Map<String, dynamic>> _navBarsItems() {
    return [
      {'icon': Icon(Icons.headset_mic), 'title': 'دعم', 'center': false},
      {'icon': Icon(Icons.message_sharp), 'title': 'رسائل', 'center': false},
      {'icon': Icon(Icons.search), 'title': 'بحث', 'center': true},
      {'icon': Icon(Icons.notifications), 'title': 'اشعارات', 'center': false},
      {'icon': Icon(Icons.person), 'title': 'حسابي', 'center': false},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return NavigationTab(
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),

    );
  }
}
