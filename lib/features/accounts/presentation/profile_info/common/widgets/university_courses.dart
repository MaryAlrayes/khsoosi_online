// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/ui/style/common_styles.dart';
import 'multiline_field.dart';

class UniversityCourses extends StatelessWidget {
  final String initialValue;
  final Function onChanged;
  const UniversityCourses({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: 'المواد الجامعية:',
              style: kBlackBoldTextStyle,
            ),
          ]),
        ),
        SizedBox(
          height: 8,
        ),
        Text('اسماء المواد الجامعية التي تقدم دروس فيها',
            style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(
          height: 8,
        ),
        MultilineField(
          hint: 'اكتب اسم المادة بالعربي وبالانجليزي مع كود المادة',
          onChanged: (value) {
            onChanged(value);
          },
          initValue: initialValue,
          onValidate: (value) {},
        )
      ],
    );
  }
}
