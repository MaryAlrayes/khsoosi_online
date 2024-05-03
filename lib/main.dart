import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/features/startup/screens/splash_screen.dart';
import 'core/locator/service_locator.dart' as sl;
import 'core/managers/routes_manager.dart';
import 'core/managers/theme_manager.dart';
import 'core/utils/services/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'features/localization/cubit/lacalization_cubit.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await PreferenceUtils.init();
  await sl.setupLocator();

  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('w = ${MediaQuery.of(context).size.width}');
    print('h = ${MediaQuery.of(context).size.height}');

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl.locator<LacalizationCubit>()..getSavedLanguage(),
        ),
      ],
      child: BlocBuilder<LacalizationCubit, LacalizationState>(
        builder: (context, state) {
          return ScreenUtilInit(
            //my emulator Nexus 6
            designSize: const Size(411.42857142857144, 683.4285714285714),
            builder: (_, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: state.locale,
              theme: getApplicationThemeData(),
              navigatorKey: navigatorKey,
              initialRoute: SplashScreen.routeName,
              onGenerateRoute: appRouter.onGenerateRoute,
            ),
          );
        },
      ),
    );
  }
}
