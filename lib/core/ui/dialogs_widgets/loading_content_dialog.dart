// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingContentDialog extends StatelessWidget {
  final String text;
  const LoadingContentDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
           text,
          ),
          const SizedBox(
            height: 8,
          ),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
