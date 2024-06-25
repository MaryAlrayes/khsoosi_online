// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_data_table.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/utils/helpers/date_formatter.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/contact_us_screen.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/pages/charge_screen.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/widgets/calls_chart.dart';

import '../../domain/entities/teacher_balance_entity.dart';
import '../../domain/entities/teacher_commissions_entity.dart';

class TeacherBalanceScreen extends StatelessWidget {
  final TeacherBalanceEntity balanceEntity;

  const TeacherBalanceScreen({
    Key? key,
    required this.balanceEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('رصيدي'),
      ),
      floatingActionButton: _buildChargeBtn(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDataTable(
                  columns: ['طريقة الدفع', 'المبلغ', 'تاريخ السداد'],
                  rows: balanceEntity.commissions
                      .map(
                        (e) => _buildRow(e),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: 16,
                ),
                _buildPaymentsNumber(balanceEntity.commissions.length)
              ],
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton _buildChargeBtn(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChargeScreen(balanceEntity: balanceEntity),
            ));
      },
      label: Text('شحن رصيد / تسديد عمولة'),
      backgroundColor: ColorManager.green1,
      foregroundColor: Colors.white,
    );
  }

  Text _buildPaymentsNumber(int length) => Text('عدد الدفعات: $length');

  DataRow _buildRow(TeacherCommissionsEntity commission) {
    return DataRow(key: UniqueKey(), cells: [
      DataCell(_buildPaymentType(commission)),
      DataCell(_buildAmount(commission)),
      DataCell(_buildDate(commission))
    ]);
  }

  Padding _buildDate(TeacherCommissionsEntity commission) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(DateFormatter.getFormatedDate(commission.date.toString())),
    );
  }

  Padding _buildAmount(TeacherCommissionsEntity commission) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(

        children: [
          Text(
            '${commission.amount} ${commission.currencyAr}',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 8,),
           Text(
            '(${commission.amountUsd} دولار أمريكي)',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  Padding _buildPaymentType(TeacherCommissionsEntity commission) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Text(
       commission.paymentType,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
