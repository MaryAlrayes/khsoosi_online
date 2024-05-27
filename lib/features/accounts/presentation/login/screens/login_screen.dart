import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/features/accounts/presentation/login/widgets/signup_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/login/widgets/social_media.dart';
import 'package:khosousi_online/features/navigation/presentation/screens/student_screen.dart';

import '../../../../../core/managers/assets_manager.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login_screen';
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(16.r),
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                height: constraints.maxHeight,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTop(constraints),
                        SizedBox(
                          height: 16.h,
                        ),
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildEmailTextField(context),
                                SizedBox(
                                  height: 12.h,
                                ),
                                _buildPasswordTextField(context),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        _buildLoginBtn(context),
                        SizedBox(
                          height: 12.h,
                        ),
                        _builSignUpBtn(context),
                        SizedBox(
                          height: 12.h,
                        ),
                        _buildOrDivider(),
                        SizedBox(
                          height: 12.h,
                        ),
                        _buildSocialMedia(),
                      ]),
                ),
              ),
            )),
      ),
    );
  }

  Container _buildTop(BoxConstraints constraints) {
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            AppAssetsManager.wallpaper,
            fit: BoxFit.contain,
            width:double.infinity,
            height: 150,
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            child: Text(
              'تسجيل الدخول',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            child: Text(
              'من الجميل رؤيتك! الرجاء تسجيل الدخول بحسابك.',
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorManager.gray4, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildOrDivider() {
    return Row(children: [
      Expanded(child: Divider()),
      SizedBox(
        width: 8.w,
      ),
      Text('أو'),
      SizedBox(
        width: 8.w,
      ),
      Expanded(child: Divider()),
    ]);
  }

  Widget _buildLoginBtn(BuildContext context) {
    return CustomElevatedButton(
      label: 'تسجيل الدخول',
      padding: EdgeInsets.symmetric(vertical: 12),
      onPressed: () {
        Navigator.pushNamed(context, StudentScreen.routeName);
      },
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.text,
          labelText: 'كلمة السر',
          validator: (value) {},
          isObscure: true,
          iconData: Icon(Icons.lock),
          withBorder: true,
          isFilled: true,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'نسيت كلمة المرور؟',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft),
          ),
        )
      ],
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return CustomTextField(
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.emailAddress,
      labelText: 'البريد الالكتروني',
      validator: (value) {},
      isObscure: false,
      iconData: Icon(Icons.email),
      withBorder: true,
      isFilled: true,
    );
  }

  Widget _buildSocialMedia() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMedia(
            icon: Image.asset(
              AppAssetsManager.googleIcon,
              scale: 20,
            ),
            onPressed: () {}),
        SizedBox(
          width: 8.w,
        ),
        SocialMedia(
            icon: Icon(
              Icons.facebook,
              color: Colors.blue,
              size: 30.w,
            ),
            onPressed: () {}),
        SizedBox(
          width: 8.w,
        ),
        SocialMedia(
            icon: Icon(
              Icons.apple,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {})
      ],
    );
  }

  Widget _builSignUpBtn(BuildContext context) {
    return SignupBtn();
  }
}
