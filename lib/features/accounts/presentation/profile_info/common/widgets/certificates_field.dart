// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';

import 'multiline_field.dart';

class CertificatesField extends StatelessWidget {
  final String initValue;
  final Function onChanged;
  const CertificatesField({
    Key? key,
    required this.initValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'الشهادات والمؤهلات',
          style: kBlackBoldTextStyle,
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          color: ColorManager.gray1,
        ),
        SizedBox(
          height: 8,
        ),
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'بإمكانك هنا التحدث عن شهاداتك ومؤهلاتك',
              style: TextStyle(fontSize: 12),
            ),
            TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red),
            ),
          ]),
        ),
        SizedBox(
          height: 8,
        ),
        MultilineField(
          hint: 'الشهادات والمؤهلات',
          onChanged: (value) {
            onChanged(value);
          },
          initValue: initValue,
          onValidate: (value) {},
        ),
        SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
