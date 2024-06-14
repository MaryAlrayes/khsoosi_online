// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Icon? icon;
  final bool? isRounded;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;
  final bool isEnabled;
  const CustomElevatedButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.backgroundColor,
      this.foregroundColor,
      this.icon,
      this.isRounded,
      this.padding,
      this.isLoading=false,
      this.isEnabled=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? _buildElevatedWithIcon(isRounded)
        : _buildElevatedWithoutIcon(isRounded);
  }

  ElevatedButton _buildElevatedWithIcon(bool? isRounded) {
    return ElevatedButton.icon(
      
      icon: icon!,
      onPressed: onPressed,
      label:isLoading? CircularProgressIndicator(): Text(
        label,
        style: TextStyle(fontSize: 14),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      style: _getStyle(isRounded),
    );
  }

  ButtonStyle _getStyle(bool? isRounded) {
    return ElevatedButton.styleFrom(
      padding: padding,
      shape: isRounded != null && isRounded ? StadiumBorder() : null,
      backgroundColor: backgroundColor ?? ColorManager.orange,
      foregroundColor: foregroundColor ?? Colors.white,
    );
  }

  Widget _buildElevatedWithoutIcon(bool? isRounded) {
    return ElevatedButton(
      onPressed: onPressed,
      child:isLoading? CircularProgressIndicator(): Text(
        label,
        maxLines: 1,
        style: TextStyle(fontSize: 14),
        overflow: TextOverflow.ellipsis,
      ),
      style: _getStyle(isRounded),
    );
  }
}

getCancelButton(BuildContext context) {
  return CustomElevatedButton(
    label: 'إغلاق',
    onPressed: () {
      Navigator.pop(context);
    },
    backgroundColor: ColorManager.gray2,
    foregroundColor: Colors.black,
  );
}
