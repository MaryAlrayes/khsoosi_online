import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

class CustomeFooter extends StatelessWidget {
  const CustomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity, child: Divider()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCopyRights(),
             SizedBox(
              width: 8.w,
            ),
            // _buildAppImage(),
          ],
        ),
      ],
    );
  }

  Column _buildCopyRights() {
    return Column(
      children: [
        Text(
          'جميع الحقوق محفوظة لموقع خصوصي أونلاين',
          style: TextStyle(
            fontSize: 14.sp,
            color: ColorManager.gray1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'privateteacher.com',
          style: TextStyle(
            fontSize: 14.sp,
            color: ColorManager.gray1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Container _buildAppImage() {
  //   return Container(
  //     height: 43.h,
  //     width: 35.w,
  //     child: Image.asset(
  //       AssetsManager.logo_image,
  //     ),
  //   );
  // }
}
