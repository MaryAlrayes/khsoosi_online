import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';

class ContactUsScreen extends StatelessWidget {
  static const routeName= 'contact_us_screen';
  ContactUsScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('تواصل معنا'),
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
                          _buildNameTextField(context),
                          SizedBox(
                            height: 16.h,
                          ),
                          _buildEmailTextField(context),
                          SizedBox(
                            height: 16.h,
                          ),
                          _buildCountryCityTextField(context),
                          SizedBox(
                            height: 16.h,
                          ),
                          _buildMessageTextField(context),
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
          label: 'إرسال',
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildNameTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'الاسم',
              style: kBlackBoldTextStyle,
            ),
            TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red),
            ),
          ]),
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'الاسم',
          validator: (value) {},
          isObscure: false,
          withBorder: true,
          isFilled: true,
        ),
      ],
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'البريد الالكتروني',
              style: kBlackBoldTextStyle,
            ),
            TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red),
            ),
          ]),
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'البريد الالكتروني',
          validator: (value) {},
          isObscure: false,
          withBorder: true,
          isFilled: true,
        ),
      ],
    );
  }

  Widget _buildCountryCityTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'الدولة والمدينة',
              style: kBlackBoldTextStyle,
            ),
            TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red),
            ),
          ]),
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'الدولة والمدينة',
          validator: (value) {},
          isObscure: false,
          withBorder: true,
          isFilled: true,
        ),
      ],
    );
  }

  Widget _buildMessageTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'الرسالة',
              style: kBlackBoldTextStyle,
            ),
            TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red),
            ),
          ]),
        ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          height: 150,
          child: CustomTextField(
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            hintText: 'الرسالة',
            validator: (value) {},
            isObscure: false,
            expand: true,
            maxLines: null,
          ),
        ),
      ],
    );
  }
}
