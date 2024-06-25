import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/utils/helpers/number_fomatter.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/statistics/domain/entities/requests_series_data_entity.dart';
import 'package:khosousi_online/features/statistics/presentation/cubit/get_teacher_stat_cubit.dart';
import 'package:khosousi_online/features/statistics/presentation/widgets/requests_line_bar.dart';
import 'package:khosousi_online/features/statistics/presentation/widgets/statistics_card_with_icon.dart';
import 'package:khosousi_online/features/statistics/presentation/widgets/statistics_card_without_icon.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;

import '../../../../core/ui/widgets/no_connection_widget.dart';
import '../../domain/entities/teacher_stat_entity.dart';

class TeacherSatatisticsScreen extends StatelessWidget {
  static const routeName = 'teacher_satatistics_screen';
  TeacherSatatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<GetTeacherStatCubit>()
        ..fetchStat(userId: context.read<AuthRepo>().getUserId()!),
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: _buildAppbar(context),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<GetTeacherStatCubit, GetTeacherStatState>(
                  builder: (context, state) {
                    if (state is GetTeacherStatInitial || state is GetTeacherStatLoading)
                      return _buildLoading();
                    else if (state is GetTeacherStatNoInternet) {
                      return _buildOffline(context);
                    } else if (state is GetTeacherStatNetworkError) {
                      return _buildError(state, context);
                    } else if (state is GetTeacherStatLoaded) {
                      return _buildContent(state.statEntity, context);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ));
      }),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(GetTeacherStatNetworkError state, BuildContext context) {
    return Center(
      child: NetworkErrorWidget(
        message: state.message,
        onPressed: () {
          BlocProvider.of<GetTeacherStatCubit>(context)
              .fetchStat(userId: context.read<AuthRepo>().getUserId()!);
        },
      ),
    );
  }

  Widget _buildOffline(BuildContext context) {
    return Center(
      child: NoConnectionWidget(
        onPressed: () {
          BlocProvider.of<GetTeacherStatCubit>(context)
              .fetchStat(userId: context.read<AuthRepo>().getUserId()!);
        },
      ),
    );
  }

  Widget _buildContent(TeacherStatEntity statEntity, BuildContext context) {
    return SingleChildScrollView(
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
                        _buildReviewsNumber(context, statEntity),
                        _buildCoursesNumber(context, statEntity),
                        _buildServicesNumber(context, statEntity),
                        _buildPortofolioNumber(context, statEntity),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Row(
                      children: [
                        _buildCurrentMonthRequestsCount(context, statEntity),
                        SizedBox(
                          width: 8,
                        ),
                        _buildLastYearRequestsMonth(context, statEntity),
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
                data: statEntity.data,
              ),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastYearRequestsMonth(
      BuildContext context, TeacherStatEntity statEntity) {
    return _buildCard2(
        context: context,
        label: 'إجمالي الطلبات أخر 12 شهر',
        number: formatNumber(statEntity.lastYearRequestCount));
  }

  Widget _buildCurrentMonthRequestsCount(
      BuildContext context, TeacherStatEntity statEntity) {
    return _buildCard2(
        context: context,
        label: 'عدد  طلبات الشهر الحالي',
        number: formatNumber(statEntity.currentMonthRequestCount));
  }

  Widget _buildPortofolioNumber(
      BuildContext context, TeacherStatEntity statEntity) {
    return _buildCard1(
        context: context,
        backgroundColor: ColorManager.lightGreen,
        foregroundColor: ColorManager.green1,
        icon: FontAwesomeIcons.book,
        label: 'عدد الشروحات',
        number: formatNumber(statEntity.portofolioCount));
  }

  Widget _buildServicesNumber(
      BuildContext context, TeacherStatEntity statEntity) {
    return _buildCard1(
        context: context,
        backgroundColor: ColorManager.lightBlue,
        foregroundColor: ColorManager.darkBlue,
        icon: FontAwesomeIcons.suitcase,
        label: 'عدد الخدمات',
        number: formatNumber(statEntity.servicesCount));
  }

  Widget _buildCoursesNumber(
      BuildContext context, TeacherStatEntity statEntity) {
    return _buildCard1(
        context: context,
        backgroundColor: ColorManager.lightPurple,
        foregroundColor: ColorManager.darkPurple,
        icon: FontAwesomeIcons.chalkboardUser,
        label: 'عدد الدورات',
        number: formatNumber(statEntity.coursesCount));
  }

  Widget _buildReviewsNumber(
      BuildContext context, TeacherStatEntity statEntity) {
    return _buildCard1(
      context: context,
      backgroundColor: ColorManager.lightYellow,
      foregroundColor: ColorManager.darkYellow,
      icon: FontAwesomeIcons.solidMessage,
      label: 'عددالتقيمات',
      number: formatNumber(statEntity.reviewsCount),
    );
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

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return getCustomAppBar(context: context);
  }
}
