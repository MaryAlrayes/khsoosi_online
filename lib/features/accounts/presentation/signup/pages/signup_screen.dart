import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/app_drop_down.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/pages/signup_first_step.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/widgets/confirm_policy.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = 'signup_screen';
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('الانضمام الى منصة خصوصي أونلاين'),),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              // Container(
              //   height: 5,
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Container(
              //           height: 5,
              //           color: ColorManager.green1,
              //         ),
              //       ),
              //       SizedBox(
              //         width: 8.w,
              //       ),
              //       Expanded(
              //         child: Container(
              //           height: 5,
              //           color: ColorManager.gray1,
              //         ),
              //       ),
              //       SizedBox(
              //         width: 8.w,
              //       ),
              //       Expanded(
              //         child: Container(
              //           height: 5,
              //           color: ColorManager.gray1,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 24.h,),
              Expanded(child: SignupFirstStep())
            ],
          ),
        ),
      ),
    );
  }
}
