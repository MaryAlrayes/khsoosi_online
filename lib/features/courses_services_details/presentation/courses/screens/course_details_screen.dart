// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/core/ui/widgets/sliver_tabbar.dart';
import 'package:khosousi_online/features/courses_services_details/domain/entities/course_service_details_entity.dart';
import 'package:khosousi_online/features/courses_services_details/presentation/courses/bloc/get_course_details_bloc.dart';
import 'package:khosousi_online/features/courses_services_details/presentation/widgets/main_details_content.dart';
import 'package:khosousi_online/features/courses_services_details/presentation/widgets/tab_about.dart';
import 'package:khosousi_online/features/courses_services_details/presentation/widgets/tab_instructor.dart';
import 'package:khosousi_online/features/courses_services_details/presentation/widgets/details_section.dart';
import 'package:khosousi_online/features/courses_services_details/presentation/widgets/tab_rates.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;

class CourseDetailsScreen extends StatelessWidget {
  static const routeName = 'course_details_screen';
  final String id;
  const CourseDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getBloc(),
      child: Builder(builder: (context) {
        return BlocBuilder<GetCourseDetailsBloc, GetCourseDetailsState>(
          builder: (context, state) {
            if (state is GetCourseDetailsLoading ||
                state is GetCourseDetailsInitial)
              return _buildLoading();
            else if (state is GetCourseDetailsNoInternet) {
              return _buildOffline(context);
            } else if (state is GetCourseDetailsNetworkError) {
              return _buildError(state, context);
            } else if (state is GetCourseDetailsLoaded) {
              return _buildMainContent(state.courseDetailsEntity);
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }

  GetCourseDetailsBloc _getBloc() => sl.locator<GetCourseDetailsBloc>()
    ..add(
      FetchCourseDetailsEvent(
        id: id,
      ),
    );

  Widget _buildLoading() {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildError(GetCourseDetailsNetworkError state, BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: NetworkErrorWidget(
          message: state.message,
          onPressed: () {
            BlocProvider.of<GetCourseDetailsBloc>(context).add(
              FetchCourseDetailsEvent(
                id: id,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOffline(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: NoConnectionWidget(
          onPressed: () {
            BlocProvider.of<GetCourseDetailsBloc>(context).add(
              FetchCourseDetailsEvent(
                id: id,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(CourseServiceDetailsEntity courseDetailsEntity) {
    return MainDetailsContent(
      courseDetailsEntity: courseDetailsEntity,
    detailsType: DetailsType.course,
    );
  }
}
