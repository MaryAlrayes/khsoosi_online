// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';

class CustomHtmlWidget extends StatelessWidget {
  final String text;
  const CustomHtmlWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(data: text, style: {
      "body": Style(
          fontSize: FontSize(14.0),
          fontWeight: FontWeight.w400,
          padding: HtmlPaddings.zero,
          margin: Margins.zero,
          color: ColorManager.htmlColor,
          textDecorationThickness: 1,
          fontStyle: FontStyle.normal,
          fontFamily: 'Roboto'),
    });
  }
}
