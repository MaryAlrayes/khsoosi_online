import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/contact_us_screen.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/widgets/calls_chart.dart';

class ChargeScreen extends StatelessWidget {
  static const routeName = 'charge_screen';
  const ChargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('شحن رصيد / تسديد عمولة'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(8)
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'رقمك الخاص هو 19 اتصل بإدارة الموقع لشحن رصيدك او سداد العمولات المستحقة عليك مع إرسال رقمك الخاص',
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
                          Navigator.pushNamed(context, ContactUsScreen.routeName);
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildStatCard1(
                      context: context,
                      backgroundColor: Color(0xffFEF9EA),
                      foregroundColor: Color(0xffF7C32E),
                      icon: FontAwesomeIcons.wallet,
                      label: 'الرصيد الكلي',
                      number: '12',
                    ),
                    _buildStatCard1(
                        context: context,
                        backgroundColor: Color(0xffEAE3F6),
                        foregroundColor: Color(0xff6F42C1),
                        icon: FontAwesomeIcons.solidMoneyBill1,
                        label: 'أخر رصيد مضاف',
                        number: '40'),
                    _buildStatCard1(
                        context: context,
                        backgroundColor: Color(0xffE7F6F8),
                        foregroundColor: Color(0xff17A2B8),
                        icon: FontAwesomeIcons.person,
                        label: 'عدد طلبات الاتصال قبل أن أكون مميز',
                        number: '24'),
                    _buildStatCard1(
                        context: context,
                        backgroundColor: ColorManager.lightGreen,
                        foregroundColor: ColorManager.green1,
                        icon: FontAwesomeIcons.personChalkboard,
                        label: 'عدد طلبات الاتصال بعد أن أصبحت مميز',
                        number: '5'),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              CallsChart()
            ],
          ),
        ),
      )),
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
}
