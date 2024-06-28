// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';

import '../../../../../../core/ui/widgets/custom_check_box_tile.dart';
import '../../../../../../core/utils/enums/enums.dart';

class TeachingMethodSelector extends StatelessWidget {
  final bool presenceInitialValue;
  final bool onlineInitialValue;
  final Function onOnlineChanged;
  final Function onPresenceChanged;
  const TeachingMethodSelector({
    Key? key,
    required this.presenceInitialValue,
    required this.onlineInitialValue,
    required this.onOnlineChanged,
    required this.onPresenceChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(
        'أسلوبك في تقديم الدروس:',
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
        label: TeachingMethod.presence.getText(),
        initValue: presenceInitialValue,
        onChanged: (value) {
          onPresenceChanged(value);
        },
      ),
      SizedBox(
        height: 8,
      ),
      CustomCheckBoxTile(
        label: TeachingMethod.online.getText(),
        initValue: onlineInitialValue,
        onChanged: (value) {
          onOnlineChanged(value);
        },
      )
    ]);
  }
}
