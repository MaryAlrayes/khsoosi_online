import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

class StatisticsCardWithoutIcon extends StatelessWidget {
  final String label;
  final String number;
  final double width;
  const StatisticsCardWithoutIcon({
    super.key,
    required this.label,
    required this.number,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.all(0),
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLabel(),
            SizedBox(
              height: 4,
            ),
            __buildNumber()
          ],
        ),
      ),
    );
  }

  FittedBox __buildNumber() {
    return FittedBox(
            child: Text(
              '$number',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
  }

  FittedBox _buildLabel() {
    return FittedBox(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ColorManager.black),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
