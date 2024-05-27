// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAccountListTile extends StatelessWidget {
  final String label;
  final Icon icon;
  final VoidCallback onPressed;
  const CustomAccountListTile({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.black,
      child: InkWell(
        splashColor: Colors.black,
        onTap: () {},
        child: GestureDetector(
          child: ListTile(
            onTap: () {
              onPressed();
            },
            title: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: icon,
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }
}
