import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

class NoConnectionWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const NoConnectionWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            'لا يوجد اتصال بالشبكة!',
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
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'من فضلك تأكد من اتصالك بالشبكة، وحاول مرة أخرى',
              style: TextStyle(fontSize: 14, color: ColorManager.gray4),
              textAlign: TextAlign.center,
            ),
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
