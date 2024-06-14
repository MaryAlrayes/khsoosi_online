import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/cubit/signup_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';

import '../../../../../core/ui/style/common_styles.dart';
import '../cubit/signup_cubit.dart';

class UserName extends StatefulWidget {
  UserName({super.key});

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildUserNameTextField(context),
                  SizedBox(
                    height: 16,
                  ),
                  _buildNameTextField(context),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NextBtn(onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<SignupStepperCubit>(context).nextStep();
                }
              }),
              SizedBox(
                height: 8,
              ),
              PreviousBtn(onPressed: () {
                BlocProvider.of<SignupStepperCubit>(context).stepBack();
              }),
            ],
          )
        ],
      ),
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
          height: 8,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'اسم المستخدم يكتب باللغة الانكليزية فقط',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لا يمكن لهذا الحقل أن يبقى فارغ';
            }
          },
          isObscure: false,
          iconData: Icon(Icons.person),
          withBorder: true,
          isFilled: true,
          initalValue:
              context.read<SignupCubit>().state.signupDataEntity.userName,
          onChanged: (value) {
            BlocProvider.of<SignupCubit>(context).setUserName(value);
          },
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
          height: 8,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'الاسم الذي سيظهر للمستخدمين الاخرين',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لا يمكن لهذا الحقل أن يبقى فارغ';
            }
          },
          initalValue: context.read<SignupCubit>().state.signupDataEntity.name,
          isObscure: false,
          iconData: Icon(Icons.person),
          withBorder: true,
          isFilled: true,
          onChanged: (value) {
            BlocProvider.of<SignupCubit>(context).setName(value);
          },
        ),
      ],
    );
  }
}
