import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/features/accounts/presentation/login/screens/choose_state_screen.dart';
import 'package:khosousi_online/features/startup/widgets/custome_footer.dart';

import '../../../core/managers/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //navigate to the first screen after 3 seconds
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(
              context,
              ChooseStateScreen.routeName,
            ));
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
