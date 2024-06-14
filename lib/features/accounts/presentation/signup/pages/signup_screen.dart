import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/assets_manager.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/accounts/presentation/login/screens/login_screen.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/cubit/signup_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/cubit/signup_stepper_cubit.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/features/accounts/presentation/signup/widgets/email_password.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/widgets/select_user_type.dart';
import 'package:khosousi_online/features/navigation/presentation/screens/teacher_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/ui/widgets/custom_elevated_btn.dart';
import '../widgets/user_name.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = 'signup_screen';
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.locator<SignupCubit>(),
        ),
        BlocProvider(
          create: (context) => sl.locator<SignupStepperCubit>(),
        ),
      ],
      child: Builder(builder: (context) {
        return BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            _buildSignupListener(state, context);
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('الانضمام الى منصة خصوصي أونلاين'),
              ),
              body: BlocBuilder<SignupStepperCubit, SignupStepperState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme:
                                ColorScheme.light(primary: ColorManager.orange),
                          ),
                          child: Stepper(
                            currentStep: state.currentIndex,
                            onStepTapped: null,
                            onStepContinue: null,
                            onStepCancel: null,
                            type: StepperType.horizontal,
                            controlsBuilder: (context, details) {
                              return Container();
                            },
                            steps: [
                              _getSelectType(
                                  state.currentStep, state.currentIndex),
                              _getUserName(
                                  state.currentStep, state.currentIndex),
                              _getEmailPassword(
                                  state.currentStep, state.currentIndex),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )),
        );
      }),
    );
  }

  void _buildSignupListener(SignupState state, BuildContext context) {
    if (state.signupStatus == SignupStatus.done) {
      _showDoneDialog(context);
    } else if (state.signupStatus == SignupStatus.noInternet) {
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state.signupStatus == SignupStatus.networkError) {
      showSnackbar(context, AppStrings.networkError);
    }
  }

  void _showDoneDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Dialog(
                backgroundColor: Colors.white,
                insetPadding: EdgeInsets.all(4),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('مبروك',
                              style: TextStyle(
                                  color: ColorManager.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.center),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(Icons.thumb_up)
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                          'تم إنشاء حسابك بنجاح، قم بتسجيل الدخول لإكمال معلوماتك وتفعيل حسابك.',
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: 500,
                        height: 200,
                        child: Lottie.asset(
                          AppAssetsManager.accepted,
                          repeat: false,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomElevatedButton(
                        label: 'تسجيل الدخول',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        backgroundColor: ColorManager.black,
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}

Step _getEmailPassword(SignupSteps currentStep, int currentIndex) {
  return Step(
    state: currentIndex >= 2 ? StepState.complete : StepState.indexed,
    isActive: currentIndex >= 2,
    title: Text(
      '',
    ),
    content: EmailPassword(),
  );
}

Step _getUserName(SignupSteps currentStep, int currentIndex) {
  return Step(
    state: currentIndex >= 1 ? StepState.complete : StepState.indexed,
    isActive: currentIndex >= 1,
    title: Text(
      '',
    ),
    content: UserName(),
  );
}

Step _getSelectType(SignupSteps currentStep, int currentIndex) {
  return Step(
    state: currentIndex >= 0 ? StepState.complete : StepState.complete,
    isActive: currentIndex >= 0,
    title: Text(
      '',
    ),
    content: SelectUserType(),
  );
}
