import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_data_table.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_round_btn.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/features/teacher_portofolio/presentation/cubit/get_teacher_portofolio_cubit.dart';
import '../../../courses_services_portofolio_details/domain/entities/portofolio_details_entity.dart';
import '../../../courses_services_portofolio_details/presentation/portofolio/screens/portofolio_details_screen.dart';
import '../../domain/entities/teacher_portofolio_entity.dart';

class TeacherPortofolioScreen extends StatelessWidget {
  const TeacherPortofolioScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<GetTeacherPortofolioCubit>()
        ..fetchPortofolio(userId: context.read<AuthRepo>().getUserId()!),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: _buildAppBar(),
          floatingActionButton: _buildAddPortofolio(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<GetTeacherPortofolioCubit,
                  GetTeacherPortofolioState>(
                builder: (context, state) {
                  if (state is GetTeacherPortofolioLoading ||
                      state is GetTeacherPortofolioInitial)
                    return _buildLoading();
                  else if (state is GetTeacherPortofolioNoInternet) {
                    return _buildOffline(context);
                  } else if (state is GetTeacherPortofolioNetworkError) {
                    return _buildError(state, context);
                  } else if (state is GetTeacherPortofolioLoaded) {
                    return _buildContent(state.portfolio, context);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(
      GetTeacherPortofolioNetworkError state, BuildContext context) {
    return Center(
      child: NetworkErrorWidget(
        message: state.message,
        onPressed: () {
          BlocProvider.of<GetTeacherPortofolioCubit>(context)
              .fetchPortofolio(userId: context.read<AuthRepo>().getUserId()!);
        },
      ),
    );
  }

  Widget _buildOffline(BuildContext context) {
    return Center(
      child: NoConnectionWidget(
        onPressed: () {
          BlocProvider.of<GetTeacherPortofolioCubit>(context)
              .fetchPortofolio(userId: context.read<AuthRepo>().getUserId()!);
        },
      ),
    );
  }

  SingleChildScrollView _buildContent(
      List<TeacherPortofolioEntity> portfolio, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDataTable(
            columns: ['العنوان', 'الحالة', 'خيارات'],
            rows: portfolio
                .map(
                  (e) => _buildRow(e, context),
                )
                .toList(),
          ),
          SizedBox(
            height: 16,
          ),
          Text('عدد الشروحات: ${portfolio.length}')
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'شروحاتي',
      ),
    );
  }

  DataRow _buildRow(TeacherPortofolioEntity portofilio, BuildContext context) {
    return DataRow(key: UniqueKey(), cells: [
      DataCell(_buildTitle(portofilio, context)),
      DataCell(_buildStatus(portofilio)),
      DataCell(_buildBtns())
    ]);
  }

  Padding _buildBtns() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          getUpdateRoundBtn(onPressed: () {}),
        ],
      ),
    );
  }

  Padding _buildStatus(TeacherPortofolioEntity portofilio) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: portofilio.isAccepted
          ? getAcceptedChip()
          : portofilio.isRejected
              ? getRejectedChip()
              : portofilio.isPending
                  ? getPendingChip()
                  : Container(),
    );
  }

  Widget _buildTitle(TeacherPortofolioEntity portofilio, BuildContext context) {
    String categories = '';
    portofilio.categories.map((e) => categories += e.nameAr + ' - ').toList();
    categories = categories.substring(0, categories.length - 2);

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PortofolioDetailsScreen(
            id: portofilio.id,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CustomImage(
                  image: portofilio.image,
                  isCircle: false,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  portofilio.title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  categories,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  FloatingActionButton _buildAddPortofolio() {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      onPressed: () {},
      label: Text('إضافة شرح مسجل'),
      backgroundColor: ColorManager.green1,
      foregroundColor: Colors.white,
    );
  }
}
