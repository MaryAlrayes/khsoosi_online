import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmPolicy extends StatefulWidget {
  const ConfirmPolicy({super.key});

  @override
  State<ConfirmPolicy> createState() => _ConfirmPolicyState();
}

class _ConfirmPolicyState extends State<ConfirmPolicy> {
  bool confirm = false;
  @override
  Widget build(BuildContext context) {
    return RichText(
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
            style: TextStyle(color: Colors.blue),
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
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );

    // Wrap(
    //   crossAxisAlignment: WrapCrossAlignment.center,
    //   alignment: WrapAlignment.start,
    //   runSpacing: 0,
    //   spacing: 0,
    //   children: [
    //     Checkbox(
    //         value: confirm,
    //         onChanged: (value) {
    //           setState(() {
    //             confirm = !confirm;
    //           });
    //         }),
    //     const Text(
    //       'قرأت و أوافق على',
    //     ),
    //     TextButton(
    //       child: const Text(
    //         'سياسة الخصوصية',
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       onPressed: () {},
    //        style: TextButton.styleFrom(
    //         padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
    //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //       ),
    //     ),
    //     Text('و'),
    //     TextButton(
    //       child: const Text(
    //         'دليل استخدام الموقع',
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       onPressed: () {},
    //       style: TextButton.styleFrom(
    //         padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
    //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //       ),
    //     ),
    //   ],
    // );
  }
}
