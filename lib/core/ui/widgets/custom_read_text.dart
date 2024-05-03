import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

class CustomReadText extends StatelessWidget {
  final String text;
  final int trimLines;
  const CustomReadText({
    Key? key,
    required this.text,
    required this.trimLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimMode: TrimMode.Line,
      trimLines: trimLines,
      trimCollapsedText: 'قراءة المزيد',
      trimExpandedText: 'قراءة أقل',
      style: TextStyle(fontSize: 14,fontFamily: 'Roboto'),
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
