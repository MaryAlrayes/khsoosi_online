import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';

class EditPasswordScreen extends StatelessWidget {
  static const routeName = 'edit_password_screen';
  EditPasswordScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('تغيير كلمة المرور'),
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
                          _buildCurrentPasswordTextField(context),
                          SizedBox(
                            height: 16.h,
                          ),
                          _buildNewPasswordTextField(context),
                          SizedBox(
                            height: 16.h,
                          ),
                          _buildConfirmPasswordTextField(context),
                          SizedBox(
                            height: 24.h,
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
        getCancelButton(context),
        CustomElevatedButton(
          backgroundColor: ColorManager.black,
          label: 'تغيير كلمة المرور',
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildCurrentPasswordTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'كلمة المرور الحالية:',
          style: kBlackBoldTextStyle,
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.text,
          hintText: '********',
          validator: (value) {},
          isObscure: true,
          iconData: Icon(Icons.lock),
          withBorder: true,
          isFilled: true,
        ),
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
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.text,
          hintText: '********',
          validator: (value) {},
          isObscure: true,
          iconData: Icon(Icons.lock),
          withBorder: true,
          isFilled: true,
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
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.text,
          hintText: '********',
          validator: (value) {},
          isObscure: true,
          iconData: Icon(Icons.lock),
          withBorder: true,
          isFilled: true,
        ),
      ],
    );
  }
}
