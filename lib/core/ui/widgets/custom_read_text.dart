// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';

class CustomReadMoreText extends StatelessWidget {
  final String text;
  final int trimLines;
  final TextStyle? textStyle;
  const CustomReadMoreText({
    Key? key,
    required this.text,
    required this.trimLines,
     this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimMode: TrimMode.Line,
      trimLines: trimLines,
      trimCollapsedText: 'قراءة المزيد',
      trimExpandedText: 'قراءة أقل',
      style:textStyle?? TextStyle(fontSize: 14,fontFamily: 'Roboto'),
      moreStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorManager.blue1,
      ),
      lessStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorManager.blue1,
      ),
    );
  }
}
