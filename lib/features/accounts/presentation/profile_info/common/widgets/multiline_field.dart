// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';

class MultilineField extends StatelessWidget {
  final String hint;
  final Function onChanged;
  const MultilineField({
    Key? key,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: CustomTextField(
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        hintText: hint,
        validator: (value) {},
        isObscure: false,
        expand: true,
        maxLines: null,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}
