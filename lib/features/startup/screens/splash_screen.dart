import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/features/accounts/presentation/login/blocs/authentication_bloc.dart';
import 'package:khosousi_online/features/startup/screens/start_up_screen.dart';
import 'package:khosousi_online/features/app_wrapper/app_wrapper.dart';
import 'package:khosousi_online/features/startup/widgets/custome_footer.dart';

import '../../../core/managers/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    if (mounted) {
      BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
    }
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppWrapper.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImage(),
                    SizedBox(
                      height: 24.h,
                    ),
                    SpinKitFadingCircle(
                      color: ColorManager.black,
                      size: 50.0,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildImage() {
    return Container(
      height: 100.h,
      width: double.infinity,
      child: Image.asset(
        AppAssetsManager.logo_black,
        fit: BoxFit.contain,
      ),
    );
  }

  CustomeFooter _buildFooter() => const CustomeFooter();
}
