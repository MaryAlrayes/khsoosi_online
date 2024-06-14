import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

class CustomTextField extends StatefulWidget {
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;
  final Icon? iconData;
  final Color backgroundColor;
  final bool? withBorder;
  final bool? isFilled;
  final bool isObscure;
  final TextEditingController? textEditingController;
  final TextAlign textAlign;
  final bool expand;
  final int? maxLines;
  final TextAlignVertical textAlignVertical;
  final String? initalValue;
  final Function(String?) validator;
  final Function? onChanged;
  final VoidCallback? onTap;
  const CustomTextField(
      {Key? key,
      required this.textInputAction,
      required this.textInputType,
      this.hintText,
      this.labelText,
      this.withBorder,
      this.iconData,
      this.isFilled,
      this.expand = false,
      this.maxLines = 1,
      this.backgroundColor = Colors.white,
      this.textEditingController,
      this.textAlign = TextAlign.start,
      this.initalValue,
      this.textAlignVertical = TextAlignVertical.center,
      this.onChanged,
      this.onTap,
      required this.validator,
      required this.isObscure,
      this.focusNode})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    show = widget.isObscure ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: TextFormField(
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        autocorrect: false,
        keyboardType: widget.textInputType,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        maxLines: widget.maxLines,
        expands: widget.expand,
        textAlignVertical: widget.textAlignVertical,
        textAlign: widget.textAlign,
        controller: widget.textEditingController,
        initialValue: widget.initalValue,
        obscuringCharacter: '●',
        cursorColor: ColorManager.orange,
        decoration: __buildFieldDecoration(
          hint: widget.hintText,
          icon: widget.iconData,
        ),
        obscureText: !show,
        validator: (value) {
          return widget.validator(value);
        },
        onTap: () {
          if (widget.focusNode != null) {
            widget.focusNode!.requestFocus();
          }
          if (widget.onTap != null) widget.onTap!();
        },
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
      ),
    );
  }

  InputDecoration __buildFieldDecoration({required String? hint, Icon? icon}) {
    return InputDecoration(
        labelText: widget.labelText,
        border: widget.withBorder != null && widget.withBorder!
            ? OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
            : InputBorder.none,
        fillColor: Colors.white,
        filled: widget.isFilled != null && widget.isFilled!,
        hintText: hint,
        prefixIcon: icon != null ? icon : null,
        suffixIcon: widget.isObscure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    show = !show;
                  });
                },
                icon: !show
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )
            : null);
  }
}
