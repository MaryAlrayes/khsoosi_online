// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/widgets/app_drop_down.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/shared_features/domain/entities/city_entity.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_cities_bloc.dart';

import '../../../../../core/ui/style/common_styles.dart';

class CitiesPicker extends StatelessWidget {
  final Function onChanged;
  final CityEntity? initValue;
  final String label;
  const CitiesPicker({
    Key? key,
    required this.onChanged,
    required this.initValue,
    required this.label,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        _buidCitiesContent(context),
      ],
    );
  }

  Widget _buidCitiesContent(BuildContext context) {
    return BlocConsumer<GetCitiesBloc, GetCitiesState>(
      listener: (context, state) {
        if (state is GetCitiesNoInternet) {
          showSnackbar(context, AppStrings.noInternetConnectionMessage);
        } else if (state is GetCitiesNetworkError) {
          showSnackbar(context, AppStrings.networkError);
        }
      },
      builder: (context, state) {
        return switch (state) {
          GetCitiesInitial() => Container(),
          GetCitiesLoading() => Column(children:[ CircularProgressIndicator()]),
          GetCitiesNoInternet() => Container(),
          GetCitiesNetworkError() => Container(),
          GetCitiesLoaded(cities: var cities) when cities.isNotEmpty =>
            _buildCitiesLoaded(cities, context),
          GetCitiesLoaded() => Text('لا يوجد مدن'),
        };
      },
    );
  }

  Widget _buildCitiesLoaded(List<CityEntity> cities, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCityLabel(context),
        SizedBox(
          height: 8,
        ),
        _buildCitiesDropDown(cities, context),
      ],
    );
  }

  Widget _buildCitiesDropDown(List<CityEntity> cities, BuildContext context) {
    return AppDropDown<CityEntity>(
        hintText: 'اختر المدينة',
        items: cities
            .map((e) => DropdownMenuItem(
                  child: Text(e.nameAr),
                  value: e,
                ))
            .toList(),
        initSelectedValue: initValue,
        onChanged: (value) {
          onChanged(value);
        });
  }

  Widget _buildCityLabel(BuildContext context) {
    return   RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
            TextSpan(
              text: label,
              style: kBlackBoldTextStyle,
            ),
          ]),
        );

  }
}
