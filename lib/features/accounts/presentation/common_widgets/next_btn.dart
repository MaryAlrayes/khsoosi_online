// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/cubit/signup_stepper_cubit.dart';

class NextBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final String label;
  final bool withIcon;
  const NextBtn(
      {Key? key,
      required this.onPressed,
      this.isLoading = false,
      this.isEnabled = true,
      this.label = 'التالي',
      this.withIcon=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: CustomElevatedButton(
        onPressed: () {
          onPressed();
        },
        label: label,
        icon: isLoading||!withIcon ? null : Icon(Icons.arrow_back, size: 14),
        backgroundColor: ColorManager.black,
        isLoading: isLoading,
        isEnabled: isEnabled,
      ),
    );
  }
}
