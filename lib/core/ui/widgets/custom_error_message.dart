// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';

class CustomErrorMessage extends StatelessWidget {
  final String errorMessage;
  const CustomErrorMessage({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ColorManager.lightRed,
          border: Border.all(width: 1, color: Colors.red)),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  'حدث خطأ! ',
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),
              ),
            ],
          ),
          Text(errorMessage)
        ],
      ),
    );
  }
}
