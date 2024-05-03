// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';

class StartUpBtn extends StatelessWidget {
  final String label;
  final Icon icon;
  final VoidCallback onPressed;
  const StartUpBtn({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200.w,
        height: 40.h,
        child: CustomElevatedButton(
          label: label,
          onPressed: onPressed,
          backgroundColor: ColorManager.black,
          foregroundColor: Colors.white,
          icon: icon,
          isRounded: true,
        ));
  }
}
