import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/app_drop_down.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/widgets/confirm_policy.dart';
import 'package:khosousi_online/features/navigation/presentation/screens/teacher_screen.dart';

class SignupFirstStep extends StatefulWidget {
  const SignupFirstStep({super.key});

  @override
  State<SignupFirstStep> createState() => _SignupFirstStepState();
}

class _SignupFirstStepState extends State<SignupFirstStep> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: constraints.maxHeight,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // _buildTop(constraints),
                Text(
                  'إنشاء الحساب',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'من فضلك ادخل معلومات التالية لانشاء حساب خاص بك على متصة خصوصي اونلاين',
                  style: TextStyle(color: ColorManager.gray1, fontSize: 14),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildType(context),
                        SizedBox(
                          height: 16.h,
                        ),
                        _buildUserNameTextField(context),
                        SizedBox(
                          height: 16.h,
                        ),
                        _buildNameTextField(context),
                        SizedBox(
                          height: 16.h,
                        ),
                        _buildEmailTextField(context),
                        SizedBox(
                          height: 16.h,
                        ),
                        _buildConfirmEmailTextField(context),
                        SizedBox(
                          height: 16.h,
                        ),
                        _buildPasswordTextField(context),
                        SizedBox(
                          height: 16.h,
                        ),
                        _buildConfirmPasswordTextField(context),
                        SizedBox(
                          height: 16.h,
                        ),
                        _buildConfirm()
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
              ]),
        ),
      ),
    );
  }

  // Container _buildTop(BoxConstraints constraints) {
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
      label: 'إنشاء الحساب',
      padding: EdgeInsets.symmetric(vertical: 12),
      onPressed: () {
          Navigator.pushNamed(context, TeacherScreen.routeName);

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
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.emailAddress,
          hintText: 'example@hotmail.com',
          validator: (value) {},
          isObscure: false,
          iconData: Icon(Icons.email),
          withBorder: true,
          isFilled: true,
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
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.emailAddress,
          hintText: 'example@hotmail.com',
          validator: (value) {},
          isObscure: false,
          iconData: Icon(Icons.email),
          withBorder: true,
          isFilled: true,
        ),
      ],
    );
  }

  Widget _buildUserNameTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'اسم المستخدم:',
              style: kBlackBoldTextStyle,
            ),
            TextSpan(
              text: '*\n',
              style: TextStyle(color: Colors.red),
            ),
            TextSpan(
              text:
                  'هذا الاسم هو معرّف خاص لك ولايمكن امتلاكه من قبل مستخدم اخر في الموقع, ضع اسم مستخدم بالانجليزي وبدون فراغات',
              style: TextStyle(fontSize: 12),
            ),
          ]),
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'اسم المستخدم يكتب باللغة الانكليزية فقط',
          validator: (value) {},
          isObscure: false,
          iconData: Icon(Icons.person),
          withBorder: true,
          isFilled: true,
        ),
      ],
    );
  }

  Widget _buildNameTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'الاسم:',
              style: kBlackBoldTextStyle,
            ),
            TextSpan(
              text: '*\n',
              style: TextStyle(color: Colors.red),
            ),
            TextSpan(
              text:
                  ' ضع اسمك الحقيقي مع الكنية, حتى يكون لك شخصية اعتبارية في الموقع ولايتشابه اسمك مع مستخدم اخر, يُمنع وضع الاسماء العامة, مثل "مدرس حاسب الي", او "مدرس رياضيات متميز" او "المحترف"',
              style: TextStyle(fontSize: 12),
            ),
          ]),
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'الاسم الذي سيظهر للمستخدمين الاخرين',
          validator: (value) {},
          isObscure: false,
          iconData: Icon(Icons.person),
          withBorder: true,
          isFilled: true,
        ),
      ],
    );
  }

  Widget _buildType(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'أنا:',
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
        AppDropDown<SignupType>(
          hintText: '',
          items: SignupType.values
              .map(
                (e) => DropdownMenuItem<SignupType>(
                  value: e,
                  child: Text(
                    e.getText(),
                  ),
                ),
              )
              .toList(),
          initSelectedValue: SignupType.student,
          onChanged: (value) {},
        )
      ],
    );
  }
}
