// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/filter/screens/filter_screen.dart';
import 'package:khosousi_online/features/search/presentation/search_institutes/bloc/get_institutes_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_services/bloc/get_services_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/bloc/get_teachers_bloc.dart';
import 'package:khosousi_online/features/location/presentation/blocs/coords_cubit.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_categories_bloc.dart';
import 'package:khosousi_online/features/location/presentation/blocs/get_cities_bloc.dart';
import 'package:khosousi_online/features/location/presentation/blocs/get_countries_bloc.dart';

import '../../search_courses/bloc/get_courses_bloc.dart';


class SearchField extends StatelessWidget {
  final SearchType searchType;
  const SearchField({
    Key? key,
    required this.searchType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5.r),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'بحث',
          prefixIcon: Icon(
            Icons.search,
          ),
        ),
        // onSubmitted:  (value) {
        //   BlocProvider.of<FilterSearchCubit>(context).setKeyword(value);
        //   _search(context);
        // },
        // onChanged: (value) {
        //   BlocProvider.of<FilterSearchCubit>(context).setKeyword(value);
        //   _search(context);
        // },
        onTap: () {
          BlocProvider.of<FilterSearchCubit>(context).saveFilter();
         barPushScreen(
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
                  value: context.read<GetInstitutesBloc>(),
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
      ),
    );
  }

}
