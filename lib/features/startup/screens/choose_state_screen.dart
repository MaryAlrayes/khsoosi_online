import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khosousi_online/core/managers/assets_manager.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/login/screens/login_screen.dart';
import 'package:khosousi_online/features/accounts/presentation/login/widgets/signup_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/pages/signup_screen.dart';
import 'package:khosousi_online/features/search/presentation/search/screens/search_screen.dart';
import 'package:khosousi_online/features/search_without_auth/presentation/pages/search_without_auth.dart';
import 'package:lottie/lottie.dart';

class ChooseStateScreen extends StatelessWidget {
  static const routeName = 'choose_state_screen';
  const ChooseStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(24)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Expanded(
                        child: _buildImage(),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      _buildLogo(),
                      SizedBox(height: 16.h),
                      _buildWelcome()
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                child: _buildLoginBtn(context),
              ),
              SizedBox(height: 8.h),
              Container(
                child: _buildSignupBtn(context),
              ),
              SizedBox(height: 8.h),
              _builSignUpBtn(context)
            ],
          ),
        ),
      ),
    );
  }

  Text _buildWelcome() {
    return Text(
      'لنوصلك بأقرب مدرس...',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container _buildLogo() {
    return Container(
      height: 50.h,
      width: double.infinity,
      child: Image.asset(
        AppAssetsManager.logo_black,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildSignupBtn(BuildContext context) {
    return CustomElevatedButton(
      label: 'بحث في خصوصي أونلاين',
      backgroundColor: ColorManager.black,
      padding: EdgeInsets.symmetric(vertical: 12),
      onPressed: () {
        Navigator.pushNamed(context, SearchWithoutAuth.routeName);
      },
      icon: Icon(Icons.search),
    );
  }

  Widget _builSignUpBtn(BuildContext context) {
    return SignupBtn();
  }

  Widget _buildLoginBtn(BuildContext context) {
    return CustomElevatedButton(
      label: 'تسجيل الدخول',
      padding: EdgeInsets.symmetric(vertical: 12),
      onPressed: () {
        Navigator.pushNamed(context, LoginScreen.routeName);
      },
    );
  }

  Widget _buildImage() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Lottie.asset(
        AppAssetsManager.online_learning,
        repeat: false,
        fit: BoxFit.contain,
      ),
    );
  }
}
