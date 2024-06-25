import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/assistence_screen.dart';
import 'package:khosousi_online/features/messages/presentation/pages/inbox_messages_screen.dart';
import 'package:khosousi_online/features/navigation/presentation/widgets/navigation_tab.dart';
import 'package:khosousi_online/features/notification/presentation/pages/notification_screen.dart';
import 'package:khosousi_online/features/teacher_account/presentation/account/pages/teacher_account_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../../notification/presentation/cubit/get_notification_cubit.dart';
import '../../../statistics/presentation/pages/teacher_statistics_screen.dart';

class TeacherScreen extends StatelessWidget {
  static const routeName = 'teacher_screen';
  TeacherScreen({super.key});
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);

  List<Widget> screens = [
    AssistenceScreen(),
    InboxMessagesScreen(),
    TeacherSatatisticsScreen(),
    NotificationScreen(),
    TeacherAccountScreen(),
  ];

  List<Map<String, dynamic>> _navBarsItems() {
    return [
      {
        'icon': Icon(Icons.headset_mic),
        'title': 'دعم',
        'center': false,
        'screen': screens[0]
      },
      {
        'icon': Icon(Icons.message_sharp),
        'title': 'رسائل',
        'center': false,
        'screen': screens[1]
      },
      {
        'icon': Icon(Icons.bar_chart),
        'title': 'احصائيات',
        'center': true,
        'screen': screens[2]
      },
      {
        'icon': BlocBuilder<GetNotificationCubit, GetNotificationState>(
          builder: (context, state) {
            return Badge(
                isLabelVisible: state.newNotificationsNumber > 0,
                alignment: Alignment.centerRight,
                label: Text(
                  '${state.newNotificationsNumber}',
                  style: TextStyle(fontFamily: 'Roboto'),
                ),
                child: Icon(Icons.notifications));
          },
        ),
        'title': 'اشعارات',
        'center': false,
        'screen': screens[3]
      },
      {
        'icon': Icon(Icons.person),
        'title': 'حسابي',
        'center': false,
        'screen': screens[4]
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return NavigationTab(
      controller: _controller,
      items: _navBarsItems(),
    );
  }
}
