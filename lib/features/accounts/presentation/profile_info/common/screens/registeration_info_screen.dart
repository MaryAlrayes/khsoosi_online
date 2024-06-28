// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/screens/institute_info.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/student/screens/student_info.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/screens/teacher_info.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';
import 'package:khosousi_online/features/location/presentation/blocs/get_cities_bloc.dart';
import 'package:khosousi_online/features/location/presentation/blocs/get_countries_bloc.dart';

class RegisterationInfoScreen extends StatelessWidget {
  final UserType userType;
  final bool  hasFinishedFirstInfo;
  const RegisterationInfoScreen({
    Key? key,
    required this.userType,
    required this.hasFinishedFirstInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                sl.locator<GetCountriesBloc>()..add(LoadCountriesEvent()),
          ),
          BlocProvider(
            create: (context) => sl.locator<GetCitiesBloc>(),
          ),
        ],
        child: Builder(builder: (context) {
          return BlocBuilder<GetCountriesBloc, GetCountriesState>(
            builder: (context, state) {
              return switch (state) {
                GetCountriesInitial() ||
                GetCountriesLoading() =>
                  _buildLoading(),
                GetCountriesNoInternet() => _buildNoInternet(context),
                GetCountriesNetworkError error =>
                  _buildNetworkError(error, context),
                GetCountriesLoaded(countries: var countries) =>
                  _buildContent(countries)
              };
            },
          );
        }),
      ),
    );
  }

  StatelessWidget _buildContent(List<CountryEntity> countries) {
    return switch (userType) {
      UserType.student => StudentInfo(
          countries: countries,
        ),
      UserType.teacher => TeacherInfo(
          countries: countries,
          hasFinishedFirstInfo: hasFinishedFirstInfo,
        ),
      UserType.institute => InstituteInfo(
          countries: countries,
          hasFinishedFirstInfo: hasFinishedFirstInfo,
        ),
    };
  }

  Widget _buildNetworkError(
      GetCountriesNetworkError error, BuildContext context) {
    return Center(
      child: NetworkErrorWidget(
        message: error.message,
        onPressed: () {
          BlocProvider.of<GetCountriesBloc>(context).add(
            LoadCountriesEvent(),
          );
        },
      ),
    );
  }

  Widget _buildNoInternet(BuildContext context) {
    return Center(
      child: NoConnectionWidget(onPressed: () {
        BlocProvider.of<GetCountriesBloc>(context).add(
          LoadCountriesEvent(),
        );
      }),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
