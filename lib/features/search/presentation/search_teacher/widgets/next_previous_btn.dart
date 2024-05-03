import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';

enum NextOrPrevious { next, previous }

class NextPreviousBtn extends StatelessWidget {
  final NextOrPrevious nextOrPrevious;
  final VoidCallback onPressed;
  const NextPreviousBtn(
      {required this.nextOrPrevious, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      label: _getLabel(),
      onPressed: onPressed,
      backgroundColor:
          nextOrPrevious == NextOrPrevious.previous ? ColorManager.gray2 : null,
      foregroundColor:
          nextOrPrevious == NextOrPrevious.previous ? Colors.black : null,
    );
  }

  String _getLabel() {
    switch (nextOrPrevious) {
      case NextOrPrevious.next:
        return 'متابعة';
      case NextOrPrevious.previous:
        return 'السابق';
    }
  }
}
