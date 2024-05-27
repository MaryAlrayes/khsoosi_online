
import 'package:flutter/material.dart';

class DoneContentDialog extends StatelessWidget {
  final String text;
  const DoneContentDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(text)
        ],
      ),
    );
  }
}
