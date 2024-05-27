import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/assistence_screen.dart';
import 'package:khosousi_online/features/messages/presentation/pages/inbox_messages_screen.dart';
import 'package:khosousi_online/features/navigation/presentation/widgets/navigation_tab.dart';
import 'package:khosousi_online/features/notification/presentation/pages/notification_screen.dart';
import 'package:khosousi_online/features/teacher_account/presentation/account/pages/teacher_account_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../statistics/presentation/pages/teacher_statistics_screen.dart';

class TeacherScreen extends StatelessWidget {
    static const routeName = 'teacher_screen';
  TeacherScreen({super.key});
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);

  List<Widget> _buildScreens() {
    return [
      AssistenceScreen(),
      InboxMessagesScreen(),
      TeacherSatatisticsScreen(),
      NotificationScreen(),
      TeacherAccountScreen(),
    ];
  }

  List<Map<String, dynamic>> _navBarsItems() {
    return [
      {'icon': Icon(Icons.headset_mic), 'title': 'دعم', 'center': false},
      {'icon': Icon(Icons.message_sharp), 'title': 'رسائل', 'center': false},
      {'icon': Icon(Icons.bar_chart), 'title': 'احصائيات', 'center': true},
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
