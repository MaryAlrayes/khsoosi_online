// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/core/managers/assets_manager.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/loading_content_dialog.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/core/utils/helpers/toast_utils.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/otp/cubit/activate_account_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/otp/cubit/resend_activation_code_cubit.dart';
import 'package:khosousi_online/features/app_wrapper/app_wrapper.dart';

import '../../login/blocs/authentication_bloc.dart';

class OtpScreen extends StatelessWidget {
  static const routeName = 'otp_screen';
  final Function onSkipClicked;
  const OtpScreen({
    Key? key,
    required this.onSkipClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.locator<ActivateAccountCubit>(),
        ),
        BlocProvider(
          create: (context) => sl.locator<ResendActivationCodeCubit>(),
        ),
      ],
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<ResendActivationCodeCubit, ResendActivationCodeState>(
                listener: (context, state) {
              _buildResendListener(state, context);
            }),
            BlocListener<ActivateAccountCubit, ActivateAccountState>(
                listener: (context, state) {
              _buildActivateCodeListener(state, context);
            }),
          ],
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildImage(context),
                        SizedBox(
                          height: 16,
                        ),
                        _buildTitle(),
                        SizedBox(
                          height: 8,
                        ),
                        _buildSubtitle(),
                        SizedBox(
                          height: 16,
                        ),
                        _buildTextField(context),
                        SizedBox(
                          height: 16,
                        ),
                        _buildResendCode(context),
                        SizedBox(
                          height: 16,
                        ),
                        _buildActivateBtn(context),
                        _buildSkip(context)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _buildActivateCodeListener(
      ActivateAccountState state, BuildContext context) {
    if (state.activateCodeStatus == ActivateCodeStatus.loading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(child: LoadingContentDialog(text: 'جاري تغعيل الحساب'));
        },
      );
    } else if (state.activateCodeStatus == ActivateCodeStatus.noInternet) {
      Navigator.pop(context);
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state.activateCodeStatus == ActivateCodeStatus.networkError) {
      Navigator.pop(context);
      showSnackbar(context, state.errorMessage);
    } else if (state.activateCodeStatus == ActivateCodeStatus.done) {
      Navigator.pop(context);
      ToastUtils.showSusToastMessage('تم تفعيل الحساب بنجاح');
      BlocProvider.of<AuthenticationBloc>(context).add(LogInUserEvent());
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppWrapper.routeName,
        (route) => false,
      );
    }
  }

  void _buildResendListener(
      ResendActivationCodeState state, BuildContext context) {
    if (state is ResendActivationCodeLoading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: LoadingContentDialog(
              text: 'جاري إعادة إرسال الكود',
            ),
          );
        },
      );
    } else if (state is ResendActivationCodesNoInternet) {
      Navigator.pop(context);
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state is ResendActivationCodeNetworkError) {
      Navigator.pop(context);
      showSnackbar(context, AppStrings.networkError);
    } else if (state is ResendActivationCodeDone) {
      Navigator.pop(context);
      ToastUtils.showSusToastMessage('تم إعادة إرسال الكود الى الايميل');
    }
  }

  PreviousBtn _buildSkip(BuildContext context) {
    return PreviousBtn(
      onPressed: () {
        onSkipClicked(context);
      },
      label: 'تخطي',
      withIcon: false,
    );
  }

  NextBtn _buildActivateBtn(BuildContext context) {
    return NextBtn(
      onPressed: () {
        if (context.read<ActivateAccountCubit>().state.code.isEmpty ||
            context.read<ActivateAccountCubit>().state.code.length < 5) {
          showSnackbar(context, 'من فضلك قم بإدخال الكود بشكل صحيح');
        } else {
          BlocProvider.of<ActivateAccountCubit>(context).submit(
            userId: context.read<AuthRepo>().getUserId()!,
          );
        }
      },
      label: 'تفعيل الحساب',
      withIcon: false,
    );
  }

  RichText _buildResendCode(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
              text: 'لم يتم إرسال الكود؟',
              style: TextStyle(color: Colors.black)),
          WidgetSpan(
            child: SizedBox(width: 4),
          ),
          TextSpan(
            text: 'إعادة إرسال الكود',
            style: TextStyle(color: ColorManager.orange),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                BlocProvider.of<ResendActivationCodeCubit>(context)
                    .resend(context.read<AuthRepo>().getUserId()!);
              },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        length: 5,
        blinkWhenObscuring: true,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          fieldOuterPadding: EdgeInsets.all(0),
          activeColor: ColorManager.orange,
          inactiveColor: ColorManager.gray1,
          selectedColor: ColorManager.orange,
        ),
        cursorColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        keyboardType: TextInputType.number,
        boxShadows: const [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
        onCompleted: (v) {
          BlocProvider.of<ActivateAccountCubit>(context).submit(
            userId: context.read<AuthRepo>().getUserId()!,
          );
        },
        onChanged: (value) {
          BlocProvider.of<ActivateAccountCubit>(context).changeCode(value);
        },
      ),
    );

  }

  Text _buildSubtitle() {
    return Text(
      'تم إرسال كود تفعيل إلى بريدك الالكتروني، قم بإدخال الكود هنا من أجل تفعيل حسابك',
      style: TextStyle(fontSize: 14, color: ColorManager.gray4),
      textAlign: TextAlign.center,
    );
  }

  Text _buildTitle() {
    return Text(
      'تفعيل الحساب',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  SvgPicture _buildImage(BuildContext context) {
    return SvgPicture.asset(
      AppAssetsManager.otp,
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
    );
  }
}
