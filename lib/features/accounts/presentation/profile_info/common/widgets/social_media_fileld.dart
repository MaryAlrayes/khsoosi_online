// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';

import '../../../login/widgets/social_media.dart';

class SocialMediaField extends StatelessWidget {

  final String initValue;
  final Icon iconData;
  final Function onChanged;
  final SocialMediaType socialMedia;
  const SocialMediaField({
    Key? key,
    required this.initValue,
    required this.iconData,
    required this.onChanged,
    required this.socialMedia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: socialMedia.getLabelForDispalay(),
              style: kBlackBoldTextStyle,
            ),
          ]),
        ),
        SizedBox(
          height: 8,
        ),
        CustomTextField(
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: socialMedia.getHintForDispalay(),
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
