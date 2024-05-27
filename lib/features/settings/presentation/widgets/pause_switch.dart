import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PauseSwitch extends StatefulWidget {
  const PauseSwitch({super.key});

  @override
  State<PauseSwitch> createState() => _PauseSwitchState();
}

class _PauseSwitchState extends State<PauseSwitch> {
  bool isActive = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(isActive ? 'نشط' : 'متوقف مؤقتا'),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              onChanged: (value) {
                setState(() {
                  isActive = value;
                });
              },
              value: isActive,
            ),
          ),
        ],
      ),
    );
  }
}
