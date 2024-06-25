// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/app_drop_down.dart';
import 'package:khosousi_online/core/ui/widgets/autocomplete_input_chip.dart';
import 'package:khosousi_online/core/ui/widgets/autocomplete_text_field.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/location/domain/entities/city_entity.dart';

import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';
import 'package:khosousi_online/features/location/presentation/blocs/get_cities_bloc.dart';

class LocationChooseCountries extends StatelessWidget {
  final List<CountryEntity> countries;
  LocationChooseCountries({
    Key? key,
    required this.countries,
  }) : super(key: key);

  late TextEditingController universityTextEditingController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCountriesContent(context),
        SizedBox(
          height: 16.h,
        ),
        _buidCitiesContent(context),
      ],
    );
  }

  Column _buildCountriesContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCountryLabel(),
        SizedBox(
          height: 8.h,
        ),
        _buildCountriesAutoComplete(context),
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
          GetCitiesLoading() => CircularProgressIndicator(),
          GetCitiesNoInternet() => Container(),
          GetCitiesNetworkError() => Container(),
          GetCitiesLoaded(cities: var cities) when cities.isNotEmpty =>
            _buildCitiesLoaded(cities, context),
          GetCitiesLoaded() => Text('لا يوجد مدن'),
        };
      },
    );
  }

  Column _buildCitiesLoaded(List<CityEntity> cities, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCityLabel(),
        SizedBox(
          height: 8.h,
        ),
        _buildCitiesDropDown(cities, context),
      ],
    );
  }

  Widget _buildCountriesAutoComplete(BuildContext context) {
    return BlocBuilder<FilterSearchCubit, FilterSearchState>(
      builder: (context, state) {
        return Autocomplete<CountryEntity>(
          initialValue: TextEditingValue(
              text: state.filter.country != null
                  ? state.filter.country!.countryNameAr.isNotEmpty
                      ? state.filter.country!.countryNameAr
                      : state.filter.country!.countryNameEn
                  : ''),
          displayStringForOption: (data) => data.countryNameAr.isNotEmpty
              ? data.countryNameAr
              : data.countryNameEn,
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            universityTextEditingController = textEditingController;

            return state.filter.country == null
                ? _buildCountriesSearchTextField(focusNode)
                : _buildCountryChip(state, context);
          },
          optionsViewBuilder: (context, onSelected, options) {
            List<CountryEntity> _items = options.toList();
            return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  color: Colors.white,
                  elevation: 4.0,
                  child: Container(
                    
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8.0),
                        itemCount: _items.length,
                        separatorBuilder: (context, i) {
                          return Divider(color: ColorManager.gray1,);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          String label = '';
                          if (_items[index].countryNameAr.isNotEmpty) {
                            label += _items[index].countryNameAr;
                          }
                          if (_items[index].countryNameEn.isNotEmpty) {
                            if (label.isNotEmpty) label += ' | ';
                            label += _items[index].countryNameEn;
                          }
                          return InkWell(
                            onTap: () {
                              onSelected(_items[index]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                label,
                              ),
                            ),
                          );
                        },
                      )),
                ));
          },
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<CountryEntity>.empty();
            }
            return countries.where(
              (element) =>
                  element.countryNameAr.toLowerCase().contains(
                        textEditingValue.text.toLowerCase(),
                      ) ||
                  element.countryNameEn
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()),
            );
          },
          onSelected: (option) {
            BlocProvider.of<FilterSearchCubit>(context).setCountry(option);
            BlocProvider.of<GetCitiesBloc>(context)
                .add(LoadCitiesEvent(country: option.countryNameEn));
          },
        );
      },
    );
  }

  Widget _buildCountryChip(FilterSearchState state, BuildContext context) {
    return AutocompleteInputChip(
      label: state.filter.country!.countryNameAr.isNotEmpty
          ? state.filter.country!.countryNameAr
          : state.filter.country!.countryNameEn,
      onDeleted: () {
        BlocProvider.of<FilterSearchCubit>(context).emptyCountry();
        BlocProvider.of<GetCitiesBloc>(context).add(ResetCitiesEvent());
        universityTextEditingController.clear();
      },
    );
  }

  Widget _buildCountriesSearchTextField(FocusNode focusNode) {
    return AutocompleteTextField(
      focusNode: focusNode,
      textEditingController: universityTextEditingController,
    );
  }

  Widget _buildCitiesDropDown(List<CityEntity> cities, BuildContext context) {
    return BlocBuilder<FilterSearchCubit, FilterSearchState>(
      builder: (context, state) {
        return AppDropDown<CityEntity>(
            hintText: 'اختر المدينة',
            items: cities
                .map((e) => DropdownMenuItem(
                      child: Text(e.nameAr),
                      value: e,
                    ))
                .toList(),
            initSelectedValue: state.filter.city,
            onChanged: (value) {
              BlocProvider.of<FilterSearchCubit>(context).setCity(value);
            });
      },
    );
  }

  Text _buildCountryLabel() {
    return Text(
      'اختر الدولة:',
      style: kBlackBoldTextStyle,
    );
  }

  Text _buildCityLabel() {
    return Text(
      'اختر المدينة:',
      style: kBlackBoldTextStyle,
    );
  }
}
