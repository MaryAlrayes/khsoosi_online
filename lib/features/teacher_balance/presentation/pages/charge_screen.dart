// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/utils/helpers/number_fomatter.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/contact_us_screen.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/widgets/calls_chart.dart';

import '../../../assistence/presentation/pages/personal_assistence.dart';
import '../../domain/entities/teacher_balance_entity.dart';

class ChargeScreen extends StatelessWidget {
  static const routeName = 'charge_screen';
  final TeacherBalanceEntity balanceEntity;

  const ChargeScreen({
    Key? key,
    required this.balanceEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildContactus(context),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildTotalCharge(context),
                    _buildLastCharge(context),
                    _buildNormalCalls(context),
                    _buildSpecialCalls(context),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              //Todo: update missing from Api
              CallsChart()
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildSpecialCalls(BuildContext context) {
    return _buildStatCard1(
        context: context,
        backgroundColor: ColorManager.lightGreen,
        foregroundColor: ColorManager.green1,
        icon: FontAwesomeIcons.personChalkboard,
        label: 'عدد طلبات الاتصال بعد أن أصبحت مميز',
        number: balanceEntity.specialCallCount.toString());
  }

  Widget _buildNormalCalls(BuildContext context) {
    return _buildStatCard1(
        context: context,
        backgroundColor: ColorManager.lightBlue,
        foregroundColor: ColorManager.blue1,
        icon: FontAwesomeIcons.person,
        label: 'عدد طلبات الاتصال قبل أن أكون مميز',
        number: balanceEntity.normalCallCount.toString());
  }

  Widget _buildLastCharge(BuildContext context) {
    return _buildStatCard1(
        context: context,
        backgroundColor: ColorManager.lightPurple,
        foregroundColor: ColorManager.darkPurple,
        icon: FontAwesomeIcons.solidMoneyBill1,
        label: 'أخر رصيد مضاف',
        number: balanceEntity.lastCharge);
  }

  Widget _buildTotalCharge(BuildContext context) {
    return _buildStatCard1(
      context: context,
      backgroundColor: ColorManager.lightYellow,
      foregroundColor: ColorManager.darkYellow,
      icon: FontAwesomeIcons.wallet,
      label: 'الرصيد الكلي',
      number: balanceEntity.totalCharge,
    );
  }

  Card _buildContactus(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'رقمك الخاص هو ${context.read<AuthRepo>().getUserId()} اتصل بإدارة الموقع لشحن رصيدك او سداد العمولات المستحقة عليك مع إرسال رقمك الخاص',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            CustomElevatedButton(
              backgroundColor: ColorManager.black,
              label: 'تواصل مع خدمة العملاء',
              icon: Icon(Icons.headset_mic),
              onPressed: () {
                Navigator.pushNamed(context, PersonalAssistenceScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text('شحن رصيد / تسديد عمولة'),
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
          height: 120,
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(8)),
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
                            formatNumber(int.parse(number)),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          label,
                          style: TextStyle(
                              fontSize: 12, overflow: TextOverflow.ellipsis),
                          maxLines: 3,
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
}
