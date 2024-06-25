// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';

class _ChartData {
  _ChartData(
    this.x,
    this.y,
    this.color,
  );

  final String x;
  final double y;
  final Color color;
}

class CallsChart extends StatefulWidget {
  const CallsChart({super.key});

  @override
  State<CallsChart> createState() => _CallsChartState();
}

class _CallsChartState extends State<CallsChart> {
  late List<_ChartData> data;
  @override
  void initState() {
    data = [
      _ChartData('طلبات موبايل', 12, ColorManager.gray1),
      _ChartData('طلبات واتساب', 15, ColorManager.blue1),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
         elevation: 2,
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'عدد المكالمات',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SfCartesianChart(
              isTransposed: true,
              primaryXAxis: CategoryAxis(),
              tooltipBehavior:
                  TooltipBehavior(enable: true, header: 'عدد المكالمات'),
              series: <CartesianSeries<_ChartData, String>>[
                BarSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'مخطط عدد المكالمات',
                  pointColorMapper: (datum, index) => datum.color,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
