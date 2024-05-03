import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final String? initalValue;
  final Function(String?) validator;
  final Function? onChanged;
  const CustomTextField(
      {Key? key,
      required this.textInputAction,
      required this.textInputType,
      this.hintText,
      this.labelText,
      this.withBorder,
      this.iconData,
      this.isFilled,
      this.backgroundColor = Colors.white,
      this.textEditingController,
      this.textAlign = TextAlign.start,
      this.initalValue,
      this.onChanged,
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
      // height: 60,
      // padding: EdgeInsets.symmetric(horizontal: 8.w),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.grey.withOpacity(.3),
      //     width: 1,
      //   ),
      //   borderRadius: BorderRadius.circular(5.r),
       color: widget.backgroundColor,
      // ),

      child: TextFormField(
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        autocorrect: false,
        keyboardType: widget.textInputType,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16
        ),
        textAlignVertical: TextAlignVertical.center,
        textAlign: widget.textAlign,
        controller: widget.textEditingController,
        initialValue: widget.initalValue,
        obscuringCharacter: '●',
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
