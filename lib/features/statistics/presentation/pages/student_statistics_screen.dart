import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/features/statistics/domain/entities/requests_series_data.dart';
import 'package:khosousi_online/features/statistics/presentation/widgets/requests_line_bar.dart';
import 'package:khosousi_online/features/statistics/presentation/widgets/statistics_card_without_icon.dart';

class StudentStatisticsScreen extends StatelessWidget {
  const StudentStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('احصائيات'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Column(
                      children: [
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
                  Expanded(
                    child: RequestsLineBar(
                      data: chartData,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildStatCard2(
      {required BuildContext context,
      required String label,
      required String number}) {
    return StatisticsCardWithoutIcon(
      label: label,
      number: number,
      width: (MediaQuery.of(context).size.width - 24) / 2,
    );
  }
}
