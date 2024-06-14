// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

class SocialMedia extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final String label;
  const SocialMedia({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(
          label,
        ),
        style: OutlinedButton.styleFrom(foregroundColor: ColorManager.black,),
      ),
    );


  }
}
