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
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/edit_password/presentation/pages/edit_password_screen.dart';
import 'package:khosousi_online/features/settings/presentation/screens/settings_screen.dart';
import 'package:khosousi_online/features/teacher_account/presentation/account/widgets/custom_account_card.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/features/teacher_courses/domain/entities/teacher_course_entity.dart';
import 'package:khosousi_online/features/teacher_courses/presentation/cubit/get_teacher_courses_cubit.dart';

import '../../../courses_services_portofolio_details/presentation/courses/screens/course_details_screen.dart';

class TeacherCoursesScreen extends StatelessWidget {
  const TeacherCoursesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<GetTeacherCoursesCubit>()
        ..fetchCourses(userId: context.read<AuthRepo>().getUserId()!),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: _buildAppBar(),
          floatingActionButton: _buildAddCourses(),
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    BlocBuilder<GetTeacherCoursesCubit, GetTeacherCoursesState>(
                  builder: (context, state) {
                    if (state is GetTeacherCoursesLoading ||
                        state is GetTeacherCoursesInitial)
                      return _buildLoading();
                    else if (state is GetTeacherCoursesNoInternet) {
                      return _buildOffline(context);
                    } else if (state is GetTeacherCoursesNetworkError) {
                      return _buildError(state, context);
                    } else if (state is GetTeacherCoursesLoaded) {
                      return _buildContent(state.courses,context);
                    } else {
                      return Container();
                    }
                  },
                )),
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
      GetTeacherCoursesNetworkError state, BuildContext context) {
    return Center(
      child: NetworkErrorWidget(
        message: state.message,
        onPressed: () {
          BlocProvider.of<GetTeacherCoursesCubit>(context)
              .fetchCourses(userId: context.read<AuthRepo>().getUserId()!);
        },
      ),
    );
  }

  Widget _buildOffline(BuildContext context) {
    return Center(
      child: NoConnectionWidget(
        onPressed: () {
          BlocProvider.of<GetTeacherCoursesCubit>(context)
              .fetchCourses(userId: context.read<AuthRepo>().getUserId()!);
        },
      ),
    );
  }

  SingleChildScrollView _buildContent(List<TeacherCourseEntity> courses,BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDataTable(
            columns: ['العنوان', 'الحالة', 'خيارات'],
            rows: courses
                .map(
                  (e) => _buildRow(e,context),
                )
                .toList(),
          ),
          SizedBox(
            height: 16,
          ),
          _buildNumberCourses(courses.length)
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'دوراتي',
      ),
    );
  }

  FloatingActionButton _buildAddCourses() {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      onPressed: () {},
      label: Text('إضافة دورة'),
      backgroundColor: ColorManager.green1,
      foregroundColor: Colors.white,
    );
  }

  Text _buildNumberCourses(int length) => Text('عدد الدورات: $length');

  DataRow _buildRow(TeacherCourseEntity course,BuildContext context) {
    return DataRow(
      key: UniqueKey(),
      cells: [
        DataCell(_buildTitle(course,context)),
        DataCell(_buildStatus(course)),
        DataCell(_buildButtons())
      ],
    );
  }

  Padding _buildButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          getUpdateRoundBtn(onPressed: () {}),
          SizedBox(
            width: 16,
          ),
          getRefreshRoundBtn(onPressed: () {}),
          SizedBox(
            width: 16,
          ),
          getDeleteRoundBtn(onPressed: () {})
        ],
      ),
    );
  }

  Padding _buildStatus(TeacherCourseEntity course) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: course.isAccepted
          ? getAcceptedChip()
          : course.isRejected
              ? getRejectedChip()
              : course.isPending
                  ? getPendingChip()
                  : Container(),
    );
  }

  Widget _buildTitle(TeacherCourseEntity course, BuildContext context) {
    String categories = '';
    course.categories.map((e) => categories += e + ' - ').toList();
    categories = categories.substring(0, categories.length - 2);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CourseDetailsScreen.routeName,
            arguments: {'id': course.id});
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
                  image: course.image,
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
                  course.name,
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
}
