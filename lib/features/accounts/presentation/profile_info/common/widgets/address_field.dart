// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/ui/style/common_styles.dart';
import 'multiline_field.dart';

class AddressField extends StatelessWidget {
  final String initValue;
  final Function onPressed;
  const AddressField({
    Key? key,
    required this.initValue,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'العنوان',
          style: kBlackBoldTextStyle,
        ),
        SizedBox(
          height: 8,
        ),
        MultilineField(
          hint: 'ادخل عنوانك الخاص بك هنا',
          onChanged: (value) {
            onPressed(value);
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
