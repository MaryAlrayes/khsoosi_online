import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticsCardWithIcon extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final String label;
  final String number;
  final double width;
  const StatisticsCardWithIcon(
      {super.key,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.icon,
      required this.label,
      required this.number,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          width: width,
          height: 100,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildIcon(constraints),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildNumber(),
                        SizedBox(height: 2),
                        _buildLabel(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Text _buildLabel() {
    return Text(
      label,
      style: TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
      maxLines: 2,
    );
  }

  FittedBox _buildNumber() {
    return FittedBox(
      child: Text(
        number,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Container _buildIcon(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.33,
      height: constraints.maxHeight,
      alignment: Alignment.center,
      child: FittedBox(
        child: Icon(
          icon,
          color: foregroundColor,
        ),
      ),
    );
  }
}
