// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/app_drop_down.dart';
import 'package:khosousi_online/core/ui/widgets/autocomplete_input_chip.dart';
import 'package:khosousi_online/core/ui/widgets/autocomplete_text_field.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/locaion_nearest.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/location_choose_countries.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/location_coords_dialog_content.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/location_type_selection.dart';
import 'package:khosousi_online/features/location/presentation/blocs/coords_cubit.dart';
import 'package:khosousi_online/features/location/presentation/blocs/get_cities_bloc.dart';
import 'package:khosousi_online/features/location/presentation/blocs/get_countries_bloc.dart';
import 'package:khosousi_online/features/location/domain/entities/city_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';

import '../../search_teacher/widgets/next_previous_btn.dart';

class LocationFilter extends StatelessWidget {
  final VoidCallback? onNextCallback;
  final VoidCallback? onPreviousCallback;
  final bool withControlBtns;
  LocationFilter({
    Key? key,
    this.onNextCallback,
    this.onPreviousCallback,
    this.withControlBtns = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCountriesBloc, GetCountriesState>(
      builder: (context, state) {
        return switch (state) {
          GetCountriesInitial() || GetCountriesLoading() => _buildLoading(),
          GetCountriesNoInternet() => _buildNoInternet(context),
          GetCountriesNetworkError error => _buildNetworkError(error, context),
          GetCountriesLoaded(countries: var countries) =>
            _buildMainContent(countries)
        };
      },
    );
  }

  BlocBuilder<FilterSearchCubit, FilterSearchState> _buildMainContent(
      List<CountryEntity> countries) {
    return BlocBuilder<FilterSearchCubit, FilterSearchState>(
        builder: (context, searchState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectLocationType(),
              SizedBox(
                height: 16.h,
              ),
              if (context.read<FilterSearchCubit>().state.filter.locationType !=
                      null &&
                  context.read<FilterSearchCubit>().state.filter.locationType ==
                      LocationType.chooseCountey)
                _buildChooseCountryContent(searchState, countries, context),

              if (context.read<FilterSearchCubit>().state.filter.locationType !=
                      null &&
                  context.read<FilterSearchCubit>().state.filter.locationType ==
                      LocationType.nearestTeacher)
                _buildNearestTeacher()
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          if (withControlBtns) _buildNextPreviousBtn(context)
        ],
      );
    });
  }

  Widget _buildNearestTeacher() {
    return LocationNearest();

  }

  Widget _buildChooseCountryContent(FilterSearchState searchState,
      List<CountryEntity> countries, BuildContext context) {
    return LocationChooseCountries(countries: countries);
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


  Row _buildNextPreviousBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBeforeBtn(context),
        _buildNextBtn(context),
      ],
    );
  }

  NextPreviousBtn _buildNextBtn(BuildContext context) {
    return NextPreviousBtn(
      nextOrPrevious: NextOrPrevious.next,
      onPressed: onNextCallback != null
          ? () {
              if (context.read<FilterSearchCubit>().state.filter.locationType ==
                  null) {
                showSnackbar(
                    context, 'عليك الاختيار قبل الانتقال للخطوة التالية');
              } else {
                print('on next ${context.read<FilterSearchCubit>().state.filter.lat}');
                onNextCallback!();
              }
            }
          : () {},
    );
  }

  Widget _buildBeforeBtn(BuildContext context) {
    return onPreviousCallback == null
        ? Container()
        : NextPreviousBtn(
            nextOrPrevious: NextOrPrevious.previous,
            onPressed: onPreviousCallback!,
          );
  }
}
