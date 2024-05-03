// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';

class CustomExpansionTile extends StatelessWidget {
  final Icon icon;
  final String title;
  final List<Widget> children;
  const CustomExpansionTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
          leading: icon,
          iconColor: ColorManager.black,
          tilePadding: EdgeInsets.symmetric(horizontal: 4),
          childrenPadding: EdgeInsets.symmetric(vertical: 2),
          title: Text(title,  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
       ),
          children: children),
    );
  }
}
