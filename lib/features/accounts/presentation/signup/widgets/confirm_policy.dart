import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/cubit/signup_cubit.dart';

class ConfirmPolicy extends StatefulWidget {
  const ConfirmPolicy({super.key});

  @override
  State<ConfirmPolicy> createState() => _ConfirmPolicyState();
}

class _ConfirmPolicyState extends State<ConfirmPolicy> {
  bool confirm = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCheckBox(),
        _buildText(context),
      ],
    );
  }

  Expanded _buildText(BuildContext context) {
    return Expanded(
      child: Container(
        child: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: 'قرأت و أوافق على',
              ),
              WidgetSpan(
                child: SizedBox(width: 4.w),
              ),
              TextSpan(
                text: 'سياسة الخصوصية',
                style: TextStyle(color: ColorManager.orange),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
              WidgetSpan(
                child: SizedBox(width: 4.w),
              ),
              TextSpan(
                text: 'و',
              ),
              WidgetSpan(
                child: SizedBox(width: 4.w),
              ),
              TextSpan(
                text: 'دليل استخدام الموقع',
                style: TextStyle(color: ColorManager.orange),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<SignupCubit, SignupState> _buildCheckBox() {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Checkbox(
            value: state.signupDataEntity. isCheckedTerms,
            onChanged: (value) {
              BlocProvider.of<SignupCubit>(context).setCheckTerms(value!);
            });
      },
    );
  }
}
