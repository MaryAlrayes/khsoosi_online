import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/features/accounts/presentation/login/screens/choose_state_screen.dart';
import 'package:khosousi_online/features/accounts/presentation/login/screens/login_screen.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/pages/signup_screen.dart';
import 'package:khosousi_online/features/navigation/presentation/screens/student_screen.dart';
import 'package:khosousi_online/features/navigation/presentation/screens/teacher_screen.dart';
import 'package:khosousi_online/features/search/presentation/filter/screens/filter_screen.dart';
import 'package:khosousi_online/features/startup/screens/splash_screen.dart';
import 'package:khosousi_online/features/startup/screens/start_screen.dart';
import 'package:khosousi_online/features/teacher_details/presentation/screens/teacher_details_screen.dart';
import 'package:khosousi_online/features/teacher_details/presentation/screens/youtube_screen.dart';

import '../../features/courses_details/presentation/screens/course_details_screen.dart';
import '../../features/search/presentation/my search/screens/my_search_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return SplashScreen();
          },
        );
      case StartScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return StartScreen();
          },
        );

      case TeacherDetailsScreen.routeName:
        final arg = routeSettings.arguments as Map;

        return MaterialPageRoute(
          builder: (context) {
            return TeacherDetailsScreen(
              teacherEntity: arg['teacher'],
            );
          },
        );

      case CourseDetailsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return CourseDetailsScreen();
          },
        );
      case MySearchScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return MySearchScreen();
          },
        );
      case FilterScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            final arg = routeSettings.arguments as Map;

            return FilterScreen(
              searchType: arg['search_type'],
            );
          },
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        );
      case ChooseStateScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ChooseStateScreen();
          },
        );
      case StudentScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return StudentScreen();
          },
        );
      case SignupScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return SignupScreen();
          },
        );
      case TeacherScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return TeacherScreen();
          },
        );
      default:
        return unDefinedRoute();
    }
  }

  Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
