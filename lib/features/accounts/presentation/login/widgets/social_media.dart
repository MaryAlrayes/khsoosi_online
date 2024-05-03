// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  const SocialMedia({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap:onPressed,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
          color: Colors.white
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: icon,
          ),
        ),
      ),
    );
  }
}
