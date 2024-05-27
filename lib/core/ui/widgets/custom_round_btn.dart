// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';

class CustomRoundBtn extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final VoidCallback onPressed;
  const CustomRoundBtn({
    Key? key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onPressed();
      },
      elevation: 1.0,
      fillColor: backgroundColor,
      child: Icon(icon, size: 16.0, color: foregroundColor),
      shape: CircleBorder(),
      constraints: const BoxConstraints(
        minWidth: 50.0,
        minHeight: 50.0,
      ),
    );
  }
}

Widget getDeleteRoundBtn({required VoidCallback onPressed}) {
  return CustomRoundBtn(
    backgroundColor: ColorManager.lightRed,
    foregroundColor: ColorManager.red1,
    icon: FontAwesomeIcons.xmark,
    onPressed:onPressed,
  );
}

Widget getRefreshRoundBtn({required VoidCallback onPressed}) {
  return CustomRoundBtn(
    backgroundColor:  ColorManager.lightBlue,
    foregroundColor:  ColorManager.blue1,
    icon: FontAwesomeIcons.arrowsRotate,
    onPressed: onPressed,
  );
}

Widget getUpdateRoundBtn({required VoidCallback onPressed}) {
  return CustomRoundBtn(
    backgroundColor:  ColorManager.lightGreen1,
    foregroundColor:  ColorManager.green1,
    icon: FontAwesomeIcons.penToSquare,
    onPressed: onPressed,
  );
}
