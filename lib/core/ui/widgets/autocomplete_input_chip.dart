// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';

class AutocompleteInputChip extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;
  const AutocompleteInputChip({
    Key? key,
    required this.label,
    required this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4.r),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(8.r),
      alignment: Alignment.centerRight,
      child: InputChip(
        label: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,

          ),
        labelStyle: const TextStyle(
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: ColorManager.gray3,
        deleteIconColor: Colors.black54,
        onPressed: () {},
        onDeleted: onDeleted
      ),
    );
  }
}
