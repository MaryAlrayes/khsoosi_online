// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';

import '../../../../core/ui/widgets/error_widget.dart';
import '../../domain/entities/institute_details_entity.dart';
import '../bloc/get_institute_details_bloc.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;

import '../widgets/institute_details.dart';
class InstituteDetailsScreen extends StatelessWidget {
final String id;
  const InstituteDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getBloc(),
      child: Builder(builder: (context) {
        return BlocBuilder<GetInstituteDetailsBloc, GetInstituteDetailsState>(
          builder: (context, state) {
            if (state is GetInstituteDetailsLoading ||
                state is GetInstituteDetailsInitial)
              return _buildLoading();
            else if (state is GetInstituteDetailsNoInternet) {
              return _buildOffline(context);
            } else if (state is GetInstituteDetailsNetworkError) {
              return _buildError(state, context);
            } else if (state is GetInstituteDetailsLoaded) {
              return _buildMainContent(state.instituteDetailsEntity);
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }

  GetInstituteDetailsBloc _getBloc() => sl.locator<GetInstituteDetailsBloc>()
    ..add(
      LoadInstitutesDetailsEvent(
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

  Widget _buildError(GetInstituteDetailsNetworkError state, BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: NetworkErrorWidget(
          message: state.message,
          onPressed: () {
            BlocProvider.of<GetInstituteDetailsBloc>(context).add(
              LoadInstitutesDetailsEvent(
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
             BlocProvider.of<GetInstituteDetailsBloc>(context).add(
              LoadInstitutesDetailsEvent(
                id: id,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(InstituteDetailsEntity institute) {
    return InstituteDetails(instituteDetailsEntity: institute,);
  }
}

