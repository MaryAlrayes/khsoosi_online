// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/managers/color_manager.dart';
import '../../../../../../core/ui/style/common_styles.dart';
import 'multiline_field.dart';

class SkillsField extends StatelessWidget {
  final String initalValue;
  final Function onChanged;
  const SkillsField({
    Key? key,
    required this.initalValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'الخبرات والمهارات',
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
              text: 'بإمكانك هنا التحدث عن خبراتك ومهاراتك',
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
          hint: 'الخبرات والمهارات',
          onChanged: (value) {
            onChanged(value);
          },
          initValue: initalValue,
          onValidate: (value) {},
        ),
        SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
