import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_details_entity.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/widgets/main_details_content.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/services/bloc/get_services_details_bloc.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;

class ServiceDetailsScreen extends StatelessWidget {
  static const routeName = 'service_details_screen';
  final String id;
  const ServiceDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getBloc(),
      child: Builder(builder: (context) {
        return BlocBuilder<GetServicesDetailsBloc, GetServicesDetailsState>(
          builder: (context, state) {
            if (state is GetServicesDetailsLoading ||
                state is GetServicesDetailsInitial)
              return _buildLoading();
            else if (state is GetServicesDetailsNoInternet) {
              return _buildOffline(context);
            } else if (state is GetServicesDetailsNetworkError) {
              return _buildError(state, context);
            } else if (state is GetServicesDetailsLoaded) {
              return _buildMainContent(state.courseDetailsEntity);
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }

  GetServicesDetailsBloc _getBloc() => sl.locator<GetServicesDetailsBloc>()
    ..add(
      FetchServiceDetailsEvent(
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

  Widget _buildError(
      GetServicesDetailsNetworkError state, BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: NetworkErrorWidget(
          message: state.message,
          onPressed: () {
            BlocProvider.of<GetServicesDetailsBloc>(context).add(
              FetchServiceDetailsEvent(
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
            BlocProvider.of<GetServicesDetailsBloc>(context).add(
              FetchServiceDetailsEvent(
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
    detailsType: DetailsType.service,
    );
  }
}
