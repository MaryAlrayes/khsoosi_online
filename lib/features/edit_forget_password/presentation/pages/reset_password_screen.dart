import 'package:flutter/material.dart';

import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/style/common_styles.dart';
import '../../../../core/ui/widgets/custom_elevated_btn.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../accounts/presentation/login/screens/login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const routeName = 'reset_password_screen';

   ResetPasswordScreen({super.key});
 final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('إعادة تعيين كلمة المرور'),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [

                                _buildNewPasswordTextField(context),
                                SizedBox(
                                  height: 16,
                                ),
                                _buildConfirmPasswordTextField(context),
                                SizedBox(
                                  height: 24,
                                ),
                                _buildBtns(context)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }


  Row _buildBtns(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       CustomElevatedButton(
          backgroundColor: ColorManager.black,
          label: 'تم',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
               Navigator.pushReplacementNamed(context, LoginScreen.routeName);

            }
          },
        )
      ],
    );
  }

  Widget _buildNewPasswordTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'كلمة المرور الجديدة:',
          style: kBlackBoldTextStyle,
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
              return 'عليك إدخال هذا الحقل';
            }
          },
          isObscure: true,
          iconData: Icon(Icons.lock),
          withBorder: true,
          isFilled: true,
          onChanged: (value) {

          },
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'تأكيد كلمة المرور الجديدة:',
          style: kBlackBoldTextStyle,
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
              return 'عليك إدخال هذا الحقل';
            }
          },
          isObscure: true,
          iconData: Icon(Icons.lock),
          withBorder: true,
          isFilled: true,
          onChanged: (value) {

          },
        ),
      ],
    );
  }
}
