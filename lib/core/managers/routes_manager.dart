import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/features/accounts/presentation/login/screens/choose_state_screen.dart';
import 'package:khosousi_online/features/accounts/presentation/login/screens/login_screen.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/pages/signup_screen.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/assistence_screen.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/contact_us_screen.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/faq_screen.dart';
import 'package:khosousi_online/features/courses_services_details/presentation/services/screens/service_details_screen.dart';
import 'package:khosousi_online/features/navigation/presentation/screens/student_screen.dart';
import 'package:khosousi_online/features/navigation/presentation/screens/teacher_screen.dart';
import 'package:khosousi_online/features/search/presentation/filter/screens/filter_screen.dart';
import 'package:khosousi_online/features/startup/screens/splash_screen.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/pages/charge_screen.dart';
import 'package:khosousi_online/features/teacher_details/presentation/screens/teacher_portofolio_details_screen.dart';
import 'package:khosousi_online/features/teacher_details/presentation/screens/teacher_details_screen.dart';
import 'package:khosousi_online/features/teacher_details/presentation/screens/teacher_service_details_screen.dart';
import '../../features/courses_services_details/presentation/courses/screens/course_details_screen.dart';
import '../../features/search/presentation/search/screens/search_screen.dart';
import '../../features/teacher_details/presentation/screens/teacher_course_details_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return SplashScreen();
          },
        );

      case SearchScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return SearchScreen();
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
      case AssistenceScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return AssistenceScreen();
          },
        );
      case FAQScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return AssistenceScreen();
          },
        );
      case ContactUsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ContactUsScreen();
          },
        );
      case ChargeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ChargeScreen();
          },
        );

      case TeacherDetailsScreen.routeName:

        final arg = routeSettings.arguments as Map;

        return MaterialPageRoute(
          builder: (context) {
            return TeacherDetailsScreen(teacherId: arg['id'],
            );
          },
        );
      case TeacherPortofolioDetailsScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return TeacherPortofolioDetailsScreen(
              portofolioEntity: arg['portofolio'],
              teacherDetailsEntity: arg['details'],
            );
          },
        );

     case TeacherCourseDetailsScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return TeacherCourseDetailsScreen(courseId: arg['id'],
            );
          },
        );

      case CourseDetailsScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return CourseDetailsScreen(id: arg['id'],
            );
          },
        );

       case ServiceDetailsScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return ServiceDetailsScreen(id: arg['id'],
            );
          },
        );

        case TeacherServiceDetailsScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return TeacherServiceDetailsScreen(serviceId: arg['id'],
            );
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
