import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/utils/helpers/number_fomatter.dart';
import 'package:khosousi_online/features/statistics/presentation/widgets/requests_line_bar.dart';
import 'package:khosousi_online/features/statistics/presentation/widgets/statistics_card_without_icon.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/no_connection_widget.dart';
import '../../../accounts/domain/repositories/auth_repo.dart';
import '../../domain/entities/student_stat_entity.dart';
import '../cubit/get_student_stat_cubit.dart';

class StudentStatisticsScreen extends StatelessWidget {
  const StudentStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<GetStudentStatCubit>()..fetchStat(userId: context.read<AuthRepo>().getUserId()!),
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: Text('احصائيات'),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<GetStudentStatCubit, GetStudentStatState>(
                  builder: (context, state) {
                   if (state is GetStudentStatLoading || state is GetStudentStatInitial)
                      return _buildLoading();
                    else if (state is GetTeacherStatNoInternet) {
                      return _buildOffline(context);
                    } else if (state is GetStudentStatNetworkError) {
                      return _buildError(state, context);
                    } else if (state is GetStudentStatLoaded) {
                      return _buildContent(state.studentStatEntity, context);
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

  Widget _buildError(GetStudentStatNetworkError state, BuildContext context) {
    return Center(
      child: NetworkErrorWidget(
        message: state.message,
        onPressed: () {
          BlocProvider.of<GetStudentStatCubit>(context)
              .fetchStat(userId: context.read<AuthRepo>().getUserId()!);
        },
      ),
    );
  }

  Widget _buildOffline(BuildContext context) {
    return Center(
      child: NoConnectionWidget(
        onPressed: () {
         BlocProvider.of<GetStudentStatCubit>(context)
              .fetchStat(userId: context.read<AuthRepo>().getUserId()!);
        },
      ),
    );
  }

  Container _buildContent(StudentStatEntity studentStatEntity,BuildContext context) {
    return Container(
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
                        number:formatNumber( studentStatEntity.currentMonthRequestCount)),
                    SizedBox(
                      width: 8,
                    ),
                    _buildStatCard2(
                        context: context,
                        label: 'إجمالي الطلبات أخر 12 شهر',
                        number: formatNumber( studentStatEntity.lastYearRequestCount)),
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
              data: studentStatEntity.data,
            ),
          ),
        ],
      ),
    );
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
