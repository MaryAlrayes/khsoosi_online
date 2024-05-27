import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_data_table.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/utils/helpers/date_formatter.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/contact_us_screen.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/pages/charge_screen.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/widgets/calls_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TeacherBalanceScreen extends StatelessWidget {
  const TeacherBalanceScreen({super.key});

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
                  columns: ['طريقة الدفع', 'المبلغ','تاريخ السداد'],
                  rows: [_buildRow(), _buildRow(), _buildRow()],
                ),
                SizedBox(
                  height: 16,
                ),
                _buildPaymentsNumber()
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
        Navigator.pushNamed(context, ChargeScreen.routeName);
      },
      label: Text('شحن رصيد / تسديد عمولة'),
      backgroundColor: ColorManager.green1,
      foregroundColor: Colors.white,
    );
  }

  Text _buildPaymentsNumber() => Text('عدد الدفعات: 6');

  DataRow _buildRow() {
    return DataRow(key: UniqueKey(), cells: [
      DataCell(_buildPaymentType()),
      DataCell(_buildAmount()),
      DataCell(_buildDate())
    ]);
  }

  Padding _buildDate() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(DateFormatter.getFormatedDate( DateTime.now().toString())),
    );
  }

  Padding _buildAmount() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('1 ريال سعودي',style: TextStyle(fontSize: 12),),
    );
  }

  Padding _buildPaymentType() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Text(
        'Cash | نقدا',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
