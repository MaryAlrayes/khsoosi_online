import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/managers/assets_manager.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../accounts/presentation/common_widgets/next_btn.dart';
import '../../../accounts/presentation/common_widgets/previous_btn.dart';
import 'reset_password_screen.dart';

class OtpForgetPasswordScreen extends StatelessWidget {
  static const routeName = 'otp_forget_password_screen';

  const OtpForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreviousBtn _buildSkip(BuildContext context) {
    return PreviousBtn(
      onPressed: () {},
      label: 'تخطي',
      withIcon: false,
    );
  }

  NextBtn _buildActivateBtn(BuildContext context) {
    return NextBtn(
      onPressed: () {
        Navigator.pushReplacementNamed(context, ResetPasswordScreen.routeName);
      },
      label: 'تم',
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
            recognizer: TapGestureRecognizer()..onTap = () {},
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
        onCompleted: (v) {},
        onChanged: (value) {},
      ),
    );
  }

  Text _buildSubtitle() {
    return Text(
      'تم إرسال كود إلى بريدك الالكتروني، قم بإدخال الكود هنا من أجل إعادة تعيين كلمة المرور',
      style: TextStyle(fontSize: 14, color: ColorManager.gray4),
      textAlign: TextAlign.center,
    );
  }

  Text _buildTitle() {
    return Text(
      'كود إعادة تعيين كلمة المرور',
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
