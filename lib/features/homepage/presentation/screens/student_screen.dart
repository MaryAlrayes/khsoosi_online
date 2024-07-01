import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/assistence_screen.dart';
import 'package:khosousi_online/features/messages/presentation/pages/inbox_messages_screen.dart';
import 'package:khosousi_online/features/homepage/presentation/widgets/navigation_tab.dart';
import 'package:khosousi_online/features/notification/presentation/cubit/get_notification_cubit.dart';
import 'package:khosousi_online/features/notification/presentation/pages/notification_screen.dart';
import 'package:khosousi_online/features/search/presentation/search/screens/search_screen.dart';
import 'package:khosousi_online/features/student_account/presentation/pages/student_account.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class StudentScreen extends StatelessWidget {
  static const routeName = 'student_screen';
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);

  List<Widget> screens = [
    AssistenceScreen(),
    InboxMessagesScreen(),
    SearchScreen(withAppBar: true),
    NotificationScreen(),
    StudentAccount(),
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
        'icon': Icon(Icons.search),
        'title': 'بحث',
        'center': true,
        'screen': screens[2]
      },
      {
        'icon': BlocBuilder<GetNotificationCubit, GetNotificationState>(
          builder: (context, state) {
            return Badge(
              isLabelVisible: state.newNotificationsNumber>0,
                alignment: Alignment.centerRight,
                label: Text('${state.newNotificationsNumber}',style: TextStyle(fontFamily: 'Roboto'),),
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
