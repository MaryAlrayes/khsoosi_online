// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomCheckBoxTile extends StatefulWidget {
  final String label;
  final bool initValue;
  final Function onChanged;
  const CustomCheckBoxTile({
    Key? key,
    required this.label,
    required this.initValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomCheckBoxTile> createState() => _CustomCheckBoxTileState();
}

class _CustomCheckBoxTileState extends State<CustomCheckBoxTile> {
  late bool value;
  @override
  void initState() {
    super.initState();
    value = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.label,
        style: TextStyle(fontSize: 12),
      ),
      value: value,
      selected: value,
      onChanged: (v) {
        setState(() {
          value = v!;
        });
        widget.onChanged(value);
      },
    );
  }
}
