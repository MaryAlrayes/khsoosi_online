// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/utils/extensions/extensions.dart';

import '../../../../../../core/managers/color_manager.dart';
import '../../../../../../core/ui/style/common_styles.dart';
import '../../../../../../core/ui/widgets/custom_check_box_tile.dart';
import '../../../../../../core/utils/enums/enums.dart';

class EducationalLevelSelector extends StatelessWidget {
  final bool elementryInitialValue;
  final bool preparatoryInitialValue;
  final bool secondaryInitialValue;
  final bool universityInitialValue;
  final Function onEelementryChanged;
  final Function onpreparatoryChanged;
  final Function onSecondaryChanged;
  final Function onUniversityChanged;
  const EducationalLevelSelector({
    Key? key,
    required this.elementryInitialValue,
    required this.preparatoryInitialValue,
    required this.secondaryInitialValue,
    required this.universityInitialValue,
    required this.onEelementryChanged,
    required this.onpreparatoryChanged,
    required this.onSecondaryChanged,
    required this.onUniversityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(
        'المراحل الدراسية التي تقدم لها الدروس: ',
        style: kBlackBoldTextStyle,
      ),
      SizedBox(
        height: 8,
      ),
      Divider(
        color: ColorManager.gray1,
      ),
      SizedBox(
        height: 8,
      ),
      CustomCheckBoxTile(
        label: EducationalLevel.elementry.getTextForDispalay(),
        initValue: elementryInitialValue,
        onChanged: (value) {
          onEelementryChanged(value);
        },
      ),
      SizedBox(
        height: 8,
      ),
      CustomCheckBoxTile(
        label: EducationalLevel.preparatory.getTextForDispalay(),
        initValue: preparatoryInitialValue,
        onChanged: (value) {
          onpreparatoryChanged(value);
        },
      ),
      SizedBox(
        height: 8,
      ),
      CustomCheckBoxTile(
        label: EducationalLevel.secondary.getTextForDispalay(),
        initValue: secondaryInitialValue,
        onChanged: (value) {
          onSecondaryChanged(value);
        },
      ),
      SizedBox(
        height: 8,
      ),
      CustomCheckBoxTile(
        label: EducationalLevel.university.getTextForDispalay(),
        initValue: universityInitialValue,
        onChanged: (value) {
          onUniversityChanged(value);
        },
      ),
      SizedBox(
        height: 32,
      )
    ]);
  }
}
