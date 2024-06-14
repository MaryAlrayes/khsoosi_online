import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_error_message.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/cubit/signup_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/cubit/signup_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';

import '../../../../../core/ui/widgets/custom_text_field.dart';
import 'confirm_policy.dart';

class EmailPassword extends StatefulWidget {
  EmailPassword({super.key});

  @override
  State<EmailPassword> createState() => _EmailPasswordState();
}

class _EmailPasswordState extends State<EmailPassword> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildEmailTextField(context),
                SizedBox(
                  height: 16,
                ),
                _buildConfirmEmailTextField(context),
                SizedBox(
                  height: 16,
                ),
                _buildPasswordTextField(context),
                SizedBox(
                  height: 16,
                ),
                _buildConfirmPasswordTextField(context),
                SizedBox(
                  height: 16,
                ),
                _buildConfirm()
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        _buildErrorMessage(),
        SizedBox(
          height: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRegisterBtn(context),
            SizedBox(
              height: 8,
            ),
            BlocBuilder<SignupCubit, SignupState>(
              builder: (context, state) {
                return PreviousBtn(
                    onPressed: state.signupStatus == SignupStatus.loading
                        ? () {}
                        : () {
                            BlocProvider.of<SignupStepperCubit>(context)
                                .stepBack();
                          });
              },
            ),
          ],
        )
      ],
    );
  }

  BlocBuilder<SignupCubit, SignupState> _buildErrorMessage() {
    return BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
      return state.errorMessage.isEmpty
          ? Container()
          : CustomErrorMessage(
              errorMessage: state.errorMessage,
            );
    });
  }

  Widget _buildRegisterBtn(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return CustomElevatedButton(
          label: 'التسجيل',
          isLoading: state.signupStatus == SignupStatus.loading,
          onPressed: state.signupStatus == SignupStatus.loading
              ? () {}
              : () {
                  final valid = _formKey.currentState!.validate();

                  final currentState = context.read<SignupCubit>().state;
                  if (valid) {
                    if (currentState.signupDataEntity.email !=
                        currentState.signupDataEntity.confirmEmail) {
                      showSnackbar(
                          context, 'البريدان الالكترونيان غير متطابقان');
                    } else if (currentState.signupDataEntity.password !=
                        currentState.signupDataEntity.confirmPassword) {
                      showSnackbar(context, 'كلمتا السر غير متطابقتان');
                    } else if (!currentState.signupDataEntity.isCheckedTerms) {
                      showSnackbar(context,
                          'عليك الموافقة على سياسة الخصوصية ودليل استخدام الموقع');
                    } else {
                      BlocProvider.of<SignupCubit>(context).submit();
                    }
                  }
                },
          backgroundColor: ColorManager.black,
        );
      },
    );
  }

  Widget _buildConfirm() {
    return ConfirmPolicy();
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'كلمة السر:',
              style: kBlackBoldTextStyle,
            ),
            TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red),
            ),
          ]),
        ),
        SizedBox(
          height: 8,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: '********',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لا يمكن لهذا الحقل أن يبقى فارغ';
            }
          },
          isObscure: true,
          iconData: Icon(Icons.lock),
          withBorder: true,
          initalValue:
              context.read<SignupCubit>().state.signupDataEntity.password,
          isFilled: true,
          onChanged: (value) {
            BlocProvider.of<SignupCubit>(context).setPassword(value);
          },
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'تأكيد كلمة السر:',
              style: kBlackBoldTextStyle,
            ),
            TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red),
            ),
          ]),
        ),
        SizedBox(
          height: 8,
        ),
        CustomTextField(
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.text,
          hintText: '********',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لا يمكن لهذا الحقل أن يبقى فارغ';
            }
          },
          isObscure: true,
          iconData: Icon(Icons.lock),
          initalValue: context
              .read<SignupCubit>()
              .state
              .signupDataEntity
              .confirmPassword,
          withBorder: true,
          isFilled: true,
          onChanged: (value) {
            BlocProvider.of<SignupCubit>(context).setConfirmPassword(value);
          },
        ),
      ],
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'البريد الالكتروني:',
              style: kBlackBoldTextStyle,
            ),
            TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red),
            ),
          ]),
        ),
        SizedBox(
          height: 8,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.emailAddress,
          hintText: 'example@hotmail.com',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لا يمكن لهذا الحقل أن يبقى فارغ';
            }
          },
          isObscure: false,
          iconData: Icon(Icons.email),
          withBorder: true,
          isFilled: true,
          initalValue: context.read<SignupCubit>().state.signupDataEntity.email,
          onChanged: (value) {
            BlocProvider.of<SignupCubit>(context).setEmail(value);
          },
        ),
      ],
    );
  }

  Widget _buildConfirmEmailTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'تأكيد البريد الالكتروني:',
              style: kBlackBoldTextStyle,
            ),
            TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red),
            ),
          ]),
        ),
        SizedBox(
          height: 8,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.emailAddress,
          hintText: 'example@hotmail.com',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لا يمكن لهذا الحقل أن يبقى فارغ';
            }
          },
          isObscure: false,
          iconData: Icon(Icons.email),
          withBorder: true,
          isFilled: true,
          initalValue:
              context.read<SignupCubit>().state.signupDataEntity.confirmEmail,
          onChanged: (value) {
            BlocProvider.of<SignupCubit>(context).setConfirmEmail(value);
          },
        ),
      ],
    );
  }
}
