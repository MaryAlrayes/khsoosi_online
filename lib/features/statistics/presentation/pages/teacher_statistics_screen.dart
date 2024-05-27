import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/features/statistics/domain/entities/requests_series_data.dart';
import 'package:khosousi_online/features/statistics/presentation/widgets/requests_line_bar.dart';
import 'package:khosousi_online/features/statistics/presentation/widgets/statistics_card_with_icon.dart';
import 'package:khosousi_online/features/statistics/presentation/widgets/statistics_card_without_icon.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

class TeacherSatatisticsScreen extends StatelessWidget {
  static const routeName = 'teacher_satatistics_screen';
  TeacherSatatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                _buildCard1(
                                  context: context,
                                  backgroundColor: Color(0xffFEF9EA),
                                  foregroundColor: Color(0xffF7C32E),
                                  icon: FontAwesomeIcons.solidMessage,
                                  label: 'عددالتقيمات',
                                  number: '12',
                                ),
                                _buildCard1(
                                    context: context,
                                    backgroundColor: Color(0xffEAE3F6),
                                    foregroundColor: Color(0xff6F42C1),
                                    icon: FontAwesomeIcons.chalkboardUser,
                                    label: 'عدد الدورات',
                                    number: '40'),
                                _buildCard1(
                                    context: context,
                                    backgroundColor: Color(0xffE7F6F8),
                                    foregroundColor: Color(0xff17A2B8),
                                    icon: FontAwesomeIcons.suitcase,
                                    label: 'عدد الخدمات',
                                    number: '24'),
                                _buildCard1(
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
                          Container(
                            child: Row(
                              children: [
                                _buildCard2(
                                    context: context,
                                    label: 'عدد  طلبات الشهر الحالي',
                                    number: '24'),
                                SizedBox(
                                  width: 8,
                                ),
                                _buildCard2(
                                    context: context,
                                    label: 'إجمالي الطلبات أخر 12 شهر',
                                    number: '24'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: RequestsLineBar(
                        data: chartData,
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

  Widget _buildCard2({
    required BuildContext context,
    required String label,
    required String number,
  }) {
    return StatisticsCardWithoutIcon(
      label: label,
      number: number,
      width: (MediaQuery.of(context).size.width - 24) / 2,
    );
  }

  Widget _buildCard1({
    required BuildContext context,
    required Color backgroundColor,
    required Color foregroundColor,
    required IconData icon,
    required String label,
    required String number,
  }) {
    return StatisticsCardWithIcon(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      icon: icon,
      label: label,
      number: number,
      width: (MediaQuery.of(context).size.width - 24) / 2,
    );
  }

  PreferredSizeWidget _buildAppbar() {
    return customeAppBar;
  }
}
