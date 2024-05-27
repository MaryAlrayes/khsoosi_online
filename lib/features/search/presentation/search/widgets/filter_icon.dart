// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/filter/screens/filter_screen.dart';
import 'package:khosousi_online/features/search/presentation/search_courses/bloc/get_courses_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_services/bloc/get_services_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/bloc/get_teachers_bloc.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/coords_cubit.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_categories_bloc.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_cities_bloc.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_countries_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class FilterIconBtn extends StatelessWidget {
  final SearchType searchType;
  const FilterIconBtn({
    Key? key,
    required this.searchType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<FilterSearchCubit>(context).saveFilter();
       pushScreen(
        context:
          context,
          screen: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: context.read<FilterSearchCubit>(),
              ),
              BlocProvider.value(
                value: context.read<GetCategoriesBloc>(),
              ),
              BlocProvider.value(
                value: context.read<GetTeachersBloc>(),
              ),
              BlocProvider.value(
                value: context.read<GetCoursesBloc>(),
              ),
                BlocProvider.value(
                value: context.read<GetServicesBloc>(),
              ),
               BlocProvider.value(
                value: context.read<GetCountriesBloc>(),
              ),
               BlocProvider.value(
                value: context.read<GetCitiesBloc>(),
              ),
                 BlocProvider.value(
                value: context.read<CoordsCubit>(),
              ),
            ],
            child: FilterScreen(searchType: searchType),
          ),
        );
      },
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8,
            ),
            color: ColorManager.orange),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.tune,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
