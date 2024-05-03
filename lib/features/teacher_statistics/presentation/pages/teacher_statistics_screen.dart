import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

class SeriesData {
  SeriesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}

class TeacherSatatisticsScreen extends StatelessWidget {
  static const routeName = 'teacher_satatistics_screen';
  TeacherSatatisticsScreen({super.key});
  final List<SeriesData> chartData = [
    SeriesData(DateTime(2022, 01), 20),
    SeriesData(DateTime(2022, 02), 10),
    SeriesData(DateTime(2022, 03), 20),
    SeriesData(DateTime(2022, 04), 30),
    SeriesData(DateTime(2022, 05), 20),
    SeriesData(DateTime(2022, 06), 30),
    SeriesData(DateTime(2022, 07), 10),
    SeriesData(DateTime(2022, 08), 20),
    SeriesData(DateTime(2022, 09), 10),
    SeriesData(DateTime(2022, 10), 30),
    SeriesData(DateTime(2022, 11), 30),
    SeriesData(DateTime(2022, 12), 30),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.scaffoldBackground,
        appBar: _buildAppbar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _buildStatCard1(
                                  context: context,
                                  backgroundColor: Color(0xffFEF9EA),
                                  foregroundColor: Color(0xffF7C32E),
                                  icon: FontAwesomeIcons.solidMessage,
                                  label: 'عددالتقيمات',
                                  number: '12',
                                ),
                                _buildStatCard1(
                                    context: context,
                                    backgroundColor: Color(0xffEAE3F6),
                                    foregroundColor: Color(0xff6F42C1),
                                    icon: FontAwesomeIcons.chalkboardUser,
                                    label: 'عدد الدورات',
                                    number: '40'),
                                _buildStatCard1(
                                    context: context,
                                    backgroundColor: Color(0xffE7F6F8),
                                    foregroundColor: Color(0xff17A2B8),
                                    icon: FontAwesomeIcons.suitcase,
                                    label: 'عدد الخدمات',
                                    number: '24'),
                                _buildStatCard1(
                                    context: context,
                                    backgroundColor: ColorManager.lightGreen,
                                    foregroundColor: ColorManager.green1,
                                    icon: FontAwesomeIcons.book,
                                    label: 'عدد الشروحات',
                                    number: '5'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              _buildStatCard2(
                                  context: context,
                                  label: 'عدد  طلبات الشهر الحالي',
                                  number: '24'),
                              SizedBox(
                                width: 8,
                              ),
                              _buildStatCard2(
                                  context: context,
                                  label: 'إجمالي الطلبات أخر 12 شهر',
                                  number: '24'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Card(
                      elevation: 2,
                      shadowColor: ColorManager.orange,
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.5,
                        ),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // color: Color(0xffFFF2E7),
                          // color: Colors.orange,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'طلبات أخر 12 شهر',
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
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: 800,
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ).copyWith(right: 24),
                                child: SfCartesianChart(
                                    backgroundColor: Colors.transparent,
                                    enableAxisAnimation: true,
                                    tooltipBehavior: TooltipBehavior(
                                        enable: true, header: 'طلبات'),
                                    primaryXAxis: DateTimeAxis(
                                      intervalType: DateTimeIntervalType.months,
                                      dateFormat: DateFormat('MM-yyyy'),
                                      desiredIntervals: 12,
                                      axisLine: AxisLine(width: 2),
                                      enableAutoIntervalOnZooming: true,
                                      autoScrollingDeltaType:
                                          DateTimeIntervalType.months,
                                      edgeLabelPlacement:
                                          EdgeLabelPlacement.none,
                                      majorGridLines: MajorGridLines(
                                        width: 2,
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
                                      LineSeries<SeriesData, DateTime>(
                                        pointColorMapper: (datum, index) =>
                                            ColorManager.orange,
                                        markerSettings: MarkerSettings(
                                            isVisible: true,
                                            shape: DataMarkerType.diamond,
                                            width: 12,
                                            height: 12),
                                        name: 'Requests',
                                        dataSource: chartData,
                                        xValueMapper: (SeriesData sales, _) =>
                                            sales.year,
                                        yValueMapper: (SeriesData sales, _) =>
                                            sales.sales,
                                        enableTooltip: true,
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Card _buildStatCard2(
      {required BuildContext context,
      required String label,
      required String number}) {
    return Card(
      elevation: 1,
      shadowColor: ColorManager.orange,
      margin: EdgeInsets.all(0),
      child: Container(
        alignment: Alignment.center,
        width: (MediaQuery.of(context).size.width - 24) / 2,
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FittedBox(
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
                      // overflow: TextOverflow.ellipsis,
                      ),
                  // maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            FittedBox(
              child: Text(
                '$number',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard1(
      {required BuildContext context,
      required Color backgroundColor,
      required Color foregroundColor,
      required IconData icon,
      required String label,
      required String number}) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          width: (MediaQuery.of(context).size.width - 24) / 2,
          height: 100,
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(12)),
          child: LayoutBuilder(
            builder: (context, constraints) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: constraints.maxWidth * 0.33,
                  height: constraints.maxHeight,
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Icon(
                      icon,
                      color: foregroundColor,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            number,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          label,
                          style: TextStyle(
                              fontSize: 12, overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  PreferredSizeWidget _buildAppbar() {
    return customeAppBar;
  }
}
