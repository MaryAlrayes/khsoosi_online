// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';

class AutocompleteTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController? textEditingController;
  const AutocompleteTextField({
    Key? key,
    required this.focusNode,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.text,
      hintText: 'ابحث',
      validator: (value) {},
      isObscure: false,
      focusNode: focusNode,
      textEditingController: textEditingController,
      iconData: Icon(
        FontAwesomeIcons.bookAtlas,
        size: 18,
      ),
      onChanged: (v) {
        focusNode.requestFocus();
      },
      backgroundColor: Colors.white,
    );
  }
}
