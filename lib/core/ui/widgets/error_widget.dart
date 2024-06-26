import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String message;
  NetworkErrorWidget({required this.message, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            'حدث خطأ أثناء الإرسال، حاول مرة أخرى',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
           SizedBox(
            height: 8.h,
          ),
          Text(
            message,
            style:  TextStyle(
              fontSize: 14,
              color: ColorManager.gray4
            ),
            textAlign: TextAlign.center,
          ),
           SizedBox(
            height: 8.h,
          ),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text(
              'حاول مجددا',
            ),
          )
        ],
      ),
    );
  }
}
