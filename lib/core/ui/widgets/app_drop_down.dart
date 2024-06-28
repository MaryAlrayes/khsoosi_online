// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropDown<T> extends StatefulWidget {
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final T? initSelectedValue;
  final Function(dynamic) onChanged;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final Icon? icon;
  const AppDropDown({
    Key? key,
    required this.hintText,
    required this.items,
    required this.initSelectedValue,
    required this.onChanged,
    this.selectedItemBuilder,
    this.icon,
  }) : super(key: key);

  @override
  State<AppDropDown<T>> createState() => _AppDropDownState<T>();
}

class _AppDropDownState<T> extends State<AppDropDown<T>> {
  T? selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.initSelectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.icon,
              ),
              SizedBox(
                width: 8,
              ),
            ],
            Expanded(
              child: ButtonTheme(
                child: DropdownButton<T>(
                  value: selectedValue,
                  hint: Text(
                    widget.hintText,
                    style: TextStyle(fontSize: 14, color: Color(0xff888888)),
                  ),
                  items: widget.items,
                  selectedItemBuilder: widget.selectedItemBuilder != null
                      ? (context) {
                         return widget.selectedItemBuilder!(context);
                        }
                      : null,
                  isExpanded: true,
                  onChanged: (value) {
                    widget.onChanged(value);
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
