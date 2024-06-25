// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/features/statistics/domain/entities/requests_series_data_entity.dart';

class RequestsLineBar extends StatelessWidget {
final List<RequestsSeriesDataEntity> data;
  const RequestsLineBar({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildLabel(),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Container(
                  width: 800,
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ).copyWith(right: 24),
                  child: _buildChart(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SfCartesianChart _buildChart() {
    return SfCartesianChart(
        backgroundColor: Colors.transparent,
        enableAxisAnimation: true,
        tooltipBehavior: TooltipBehavior(enable: true, header: 'طلبات'),
       
        primaryXAxis: CategoryAxis(
           axisLine: AxisLine(width: 2),
            majorGridLines: MajorGridLines(
            width: 1,
            color: Colors.black12,
          ),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(
            width: 2,
            color: Colors.black12,
          ),
        ),
        series: <CartesianSeries>[
          LineSeries<RequestsSeriesDataEntity, String>(
            pointColorMapper: (datum, index) => ColorManager.orange,
            markerSettings: MarkerSettings(
                isVisible: true,
                shape: DataMarkerType.diamond,
                width: 12,
                height: 12),
            dataSource: data,
            xValueMapper: (RequestsSeriesDataEntity sales, _) => sales.month,
            yValueMapper: (RequestsSeriesDataEntity sales, _) => sales.value,
            enableTooltip: true,
          )
        ]);
  }

  Padding _buildLabel() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'طلبات أخر 12 شهر',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
