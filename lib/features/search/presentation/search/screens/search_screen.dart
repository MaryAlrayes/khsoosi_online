import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/assets_manager.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/filter/screens/filter_screen.dart';
import 'package:khosousi_online/features/search/presentation/search/cubit/search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search/widgets/custom_circle.dart';
import 'package:khosousi_online/features/search/presentation/search/widgets/filter_icon.dart';
import 'package:khosousi_online/features/search/presentation/search/widgets/search_field.dart';
import 'package:khosousi_online/features/search/presentation/search_courses/bloc/get_courses_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_courses/screens/search_courses_result.dart';
import 'package:khosousi_online/features/search/presentation/search_institutes/screens/search_instituts_result.dart';
import 'package:khosousi_online/features/search/presentation/search_services/bloc/get_services_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_services/screens/search_services_result.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/bloc/get_teachers_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/screens/search_teachers_result.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/shared_features/presentation/bloc/coords_cubit.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_categories_bloc.dart';

import '../../../../../shared_features/presentation/bloc/get_cities_bloc.dart';
import '../../../../../shared_features/presentation/bloc/get_countries_bloc.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = 'my_search_screen';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getSearchCubit()),
        BlocProvider(create: (context) => _getFilterSearchBloc()),
        BlocProvider(create: (context) => _getCategoriesBloc()),
        BlocProvider(create: (context) => _getCitiesBloc()),
        BlocProvider(create: (context) => _getCountriesBloc()),
        BlocProvider(create: (context) => _getTeachers(context)),
        BlocProvider(create: (context) => _getCourses(context)),
        BlocProvider(create: (context) => _getServices(context)),
        BlocProvider(create: (context) => _getCoordsCubit()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: ColorManager.scaffoldBackground,
          appBar: _buildAppbar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildSearchField(state),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                _buildFilterIcon(context, state)
                              ],
                            ),
                          ),
                        ),
                        Container(

                          height: 100,
                          width: double.infinity,
                          child: _buildCircles(state),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _buildContent(state.searchType),
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppbar() {
    return customeAppBar;
  }

  Widget _buildCircles(SearchState state) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        CustomCircle(
          label: 'مدرسين',
          icon: FontAwesomeIcons.chalkboardUser,
          isSelected: state.searchType == SearchType.teachers,
          searchType: SearchType.teachers,
        ),
        CustomCircle(
          label: 'دورات',
          icon: FontAwesomeIcons.bookAtlas,
          isSelected: state.searchType == SearchType.courses,
          searchType: SearchType.courses,
        ),
        CustomCircle(
          label: 'معاهد',
          icon: FontAwesomeIcons.buildingColumns,
          isSelected: state.searchType == SearchType.institutes,
          searchType: SearchType.institutes,
        ),
        CustomCircle(
          label: 'خدمات',
          icon: FontAwesomeIcons.pencil,
          isSelected: state.searchType == SearchType.services,
          searchType: SearchType.services,
        )
      ],
    );
  }

  Widget _buildSearchField(SearchState state) {
    return SearchField(
      searchType: state.searchType,
    );
  }

  Widget _buildFilterIcon(BuildContext context, SearchState state) {
    return FilterIconBtn(searchType: state.searchType);
  }

  Widget _buildContent(SearchType searchType) {
    return switch (searchType) {
      SearchType.teachers => SearchTeachersResult(

        ),
      SearchType.courses => SearchCoursesResult(

        ),
      SearchType.institutes => SearchInstitutesScreen(

        ),
      SearchType.services => SearchServicesResult(

        ),
    };
  }

  CoordsCubit _getCoordsCubit() => sl.locator<CoordsCubit>();

  GetTeachersBloc _getTeachers(BuildContext context) {
    return sl.locator<GetTeachersBloc>()
      ..add(
        LoadTeachersEvent(
          refresh: true,
          filter: context.read<FilterSearchCubit>().state.filter,
        ),
      );
  }

  GetCoursesBloc _getCourses(BuildContext context) {
    return sl.locator<GetCoursesBloc>()
      ..add(
        LoadCoursesEvent(
          refresh: true,
          filter: context.read<FilterSearchCubit>().state.filter,
        ),
      );
  }
  GetServicesBloc _getServices(BuildContext context) {
    return sl.locator<GetServicesBloc>()
      ..add(
        LoadServicesEvent(
          refresh: true,
          filter: context.read<FilterSearchCubit>().state.filter,
        ),
      );
  }

  GetCategoriesBloc _getCategoriesBloc() {
    return sl.locator<GetCategoriesBloc>()
      ..add(
        LoadCategoriesEvent(),
      );
  }

  GetCitiesBloc _getCitiesBloc() {
    return sl.locator<GetCitiesBloc>();
  }

  GetCountriesBloc _getCountriesBloc() {
    return sl.locator<GetCountriesBloc>()..add(LoadCountriesEvent());
  }

  FilterSearchCubit _getFilterSearchBloc() => sl.locator<FilterSearchCubit>();

  SearchCubit _getSearchCubit() => sl.locator<SearchCubit>();
}
