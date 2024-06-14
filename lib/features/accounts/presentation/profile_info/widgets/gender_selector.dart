// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';

import 'package:khosousi_online/core/ui/widgets/app_drop_down.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';

class GenderSelector extends StatelessWidget {
  final Gender initalVelue;
  final Function onChanged;
  const GenderSelector({
    Key? key,
    required this.initalVelue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      RichText(
        text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
          TextSpan(
            text: 'الجنس:',
            style: kBlackBoldTextStyle,
          ),
        
        ]),
      ),
      SizedBox(height: 8),
      AppDropDown<Gender>(
          hintText: 'الجنس',
          items: Gender.values
              .map((e) => DropdownMenuItem(
                    child: Text(
                      e.getText(),
                      style: TextStyle(fontSize: 14),
                    ),
                    value: e,
                  ))
              .toList(),

          initSelectedValue: initalVelue,
          onChanged: (value) {
            onChanged(value);
          }),
    ]);
  }
}
