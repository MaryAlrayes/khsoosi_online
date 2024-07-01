import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/accounts/presentation/login/blocs/authentication_bloc.dart';
import 'package:khosousi_online/features/accounts/presentation/login/cubit/login_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/login/widgets/signup_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/login/widgets/social_media.dart';
import 'package:khosousi_online/features/app_wrapper/app_wrapper.dart';
import 'package:khosousi_online/features/homepage/presentation/screens/student_screen.dart';

import '../../../../../core/managers/assets_manager.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;

import '../../../../edit_forget_password/presentation/pages/forget_password_screen.dart';

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
    return BlocProvider(
      create: (context) => sl.locator<LoginCubit>(),
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<LoginCubit, LoginState>(listener: (context, state) {
              _buildLoginListener(state, context);
            }),
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                // _buildAuthListener(state, context);
              },
            ),
          ],
          child: Scaffold(
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
                              _buildOrDivider(),
                              SizedBox(
                                height: 12.h,
                              ),
                              _buildSocialMedia(),
                              SizedBox(
                                height: 12.h,
                              ),
                              _builSignUpBtn(context),
                            ]),
                      ),
                    ),
                  )),
            ),
          ),
        );
      }),
    );
  }

  void _buildLoginListener(LoginState state, BuildContext context) {
    if (state.loginStatus == LoginStatus.done) {
      BlocProvider.of<AuthenticationBloc>(context).add(UpdateEvent());
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppWrapper.routeName,
        (route) => false,
      );
    } else if (state.loginStatus == LoginStatus.noInternet) {
      showSnackbar(context,AppStrings.noInternetConnectionMessage);
    } else if (state.loginStatus == LoginStatus.networkError) {
      showSnackbar(context, '${state.errorMessage}');
    }
  }



  Container _buildTop(BoxConstraints constraints) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            AppAssetsManager.wallpaper,
            fit: BoxFit.contain,
            width: double.infinity,
            height: 100.h,
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            child: Text(
              'حياك الله!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            child: Text(
              'قم بتسجيل الدخول لحسابك للاستفادة من جميع مزايا التطبيق.',
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
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return CustomElevatedButton(
          label: 'تسجيل الدخول',
          isLoading: state.loginStatus == LoginStatus.loading,
          onPressed: state.loginStatus == LoginStatus.loading
              ? () {}
              : () {
                  final valid = _formKey.currentState!.validate();

                  if (valid) {
                    BlocProvider.of<LoginCubit>(context).submit();
                  }
                },
          backgroundColor: ColorManager.black,
        );
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'لا يمكن لهذا الحقل أن يبقى فارغ';
              }
            },
            isObscure: true,
            iconData: Icon(Icons.lock),
            withBorder: true,
            isFilled: true,
            onChanged: (value) {
              BlocProvider.of<LoginCubit>(context).setPassword(value);
            }),
        Container(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, ForgetPasswordScreen.routeName);

            },
            child: Text(
              'نسيت كلمة المرور؟',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft,
              // foregroundColor: ColorManager.black,
            ),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'لا يمكن لهذا الحقل أن يبقى فارغ';
        }
      },
      isObscure: false,
      iconData: Icon(Icons.email),
      withBorder: true,
      isFilled: true,
      onChanged: (value) {
        BlocProvider.of<LoginCubit>(context).setEmail(value);
      },
    );
  }

  Widget _buildSocialMedia() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SocialMedia(
          icon: Image.asset(
            AppAssetsManager.googleIcon,
            scale: 20,
          ),
          onPressed: () {},
          label: 'تسجيل باستخدام جوجل',
        ),
        SizedBox(height: 8),
        SocialMedia(
            icon: Icon(
              Icons.apple,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
            label: 'تسجيل باستخدام أبل')
      ],
    );
  }

  Widget _builSignUpBtn(BuildContext context) {
    return SignupBtn();
  }
}
