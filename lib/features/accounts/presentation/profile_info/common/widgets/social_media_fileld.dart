import 'package:flutter/material.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';

class SocialMediaField extends StatelessWidget {
  final String label;
  final String hintText;
  final String initValue;
  final Icon iconData;
  final Function onChanged;
  const SocialMediaField(
      {required this.label,
      required this.hintText,
      required this.initValue,
      required this.iconData,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: label,
              style: kBlackBoldTextStyle,
            ),
          ]),
        ),
        SizedBox(height: 8,),
       CustomTextField(
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.text,
            hintText: hintText,
            iconData: iconData,
            validator: (value) {},
            isObscure: false,
            withBorder: true,
            isFilled: true,
            initalValue: initValue,
            onChanged: (value) {
              onChanged(value);
            },
          ),
        
      ],
    );
  }
}
