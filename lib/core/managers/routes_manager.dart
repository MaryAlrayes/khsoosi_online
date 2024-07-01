import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/pages/conditions_screen.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/pages/institute_conditions.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/pages/student_conditions.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/pages/teacher_conditions.dart';
import 'package:khosousi_online/features/edit_forget_password/presentation/pages/forget_password_screen.dart';
import 'package:khosousi_online/features/edit_forget_password/presentation/pages/reset_password_screen.dart';
import 'package:khosousi_online/features/location/presentation/pages/location_map_screen.dart';
import 'package:khosousi_online/features/search_without_auth/presentation/pages/search_without_auth.dart';
import 'package:khosousi_online/features/startup/screens/start_up_screen.dart';
import 'package:khosousi_online/features/accounts/presentation/login/screens/login_screen.dart';
import 'package:khosousi_online/features/accounts/presentation/otp/screens/otp_screen.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/pages/signup_screen.dart';
import 'package:khosousi_online/features/app_wrapper/app_wrapper.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/assistence_screen.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/contact_us_screen.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/faq_screen.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/services/screens/service_details_screen.dart';
import 'package:khosousi_online/features/homepage/presentation/screens/student_screen.dart';
import 'package:khosousi_online/features/homepage/presentation/screens/teacher_screen.dart';
import 'package:khosousi_online/features/search/presentation/filter/screens/filter_screen.dart';
import 'package:khosousi_online/features/startup/screens/splash_screen.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/pages/charge_screen.dart';
import 'package:khosousi_online/features/teacher_details/presentation/screens/teacher_portofolio_details_screen.dart';
import 'package:khosousi_online/features/teacher_details/presentation/screens/teacher_details_screen.dart';
import 'package:khosousi_online/features/teacher_details/presentation/screens/teacher_service_details_screen.dart';
import '../../features/assistence/presentation/pages/personal_assistence.dart';
import '../../features/courses_services_portofolio_details/presentation/courses/screens/course_details_screen.dart';
import '../../features/edit_forget_password/presentation/pages/otp_forget_password_screen.dart';
import '../../features/search/presentation/search/screens/search_screen.dart';
import '../../features/teacher_balance/presentation/pages/balance_screen.dart';
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
      case AppWrapper.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return AppWrapper();
          },
        );
      case SearchWithoutAuth.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return SearchWithoutAuth();
          },
        );
      case SearchScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return SearchScreen(withAppBar: arg['withAppBar']);
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
      case StartUpScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return StartUpScreen();
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
      case PersonalAssistenceScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return PersonalAssistenceScreen();
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

      case TeacherDetailsScreen.routeName:
        final arg = routeSettings.arguments as Map;

        return MaterialPageRoute(
          builder: (context) {
            return TeacherDetailsScreen(
              teacherId: arg['id'],
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
            return TeacherCourseDetailsScreen(
              courseId: arg['id'],
            );
          },
        );

      case CourseDetailsScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return CourseDetailsScreen(
              id: arg['id'],
            );
          },
        );

      case ServiceDetailsScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return ServiceDetailsScreen(
              id: arg['id'],
            );
          },
        );

      case TeacherServiceDetailsScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return TeacherServiceDetailsScreen(
              serviceId: arg['id'],
            );
          },
        );

      case OtpScreen.routeName:
        final args = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return OtpScreen(
              onSkipClicked: args['onSkip'] as Function,
            );
          },
        );

      case LocationMapScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LocationMapScreen();
          },
        );
      case ConditionsScreen.routeName:
        final args = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return ConditionsScreen(
              userType: args['userType'],
            );
          },
        );
      case StudentConditions.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return StudentConditions();
          },
        );
      case TeacherConditions.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return TeacherConditions();
          },
        );
      case InstituteConditions.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return InstituteConditions();
          },
        );
      case BalanceScreen.routeName:
        final args = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return BalanceScreen(
              balanceScreenType: args['type'],
            );
          },
        );
      case ForgetPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ForgetPasswordScreen();
          },
        );
          case OtpForgetPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return OtpForgetPasswordScreen();
          },
        );
          case ResetPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ResetPasswordScreen();
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
