import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_institutes/widgets/institute_item.dart';
import 'package:khosousi_online/features/search/presentation/search_institutes/widgets/search_institutes_filter_section.dart';

class SearchInstitutesScreen extends StatelessWidget {
 final bool showFilter;
  const SearchInstitutesScreen({
    Key? key,
     this.showFilter=true,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          if(showFilter)...[  SizedBox(
              width: double.infinity,
              child: _builsSelectedSearchFilter(),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
            Container(child: _buildInstitutesList()),
          ],
        ),
      ),
    );
  }

  Widget _builsSelectedSearchFilter() {
    return BlocBuilder<FilterSearchCubit, FilterSearchState>(
      builder: (context, state) {
        return SearchInstitutesFilterSection(
            searchFilterEntity: SearchFilterEntity(
          teachingMethod:
              context.read<FilterSearchCubit>().state.filter.teachingMethod,
          city: context.read<FilterSearchCubit>().state.filter.city,
          country: context.read<FilterSearchCubit>().state.filter.country,
          educationalLevel:
              context.read<FilterSearchCubit>().state.filter.educationalLevel,
          speciality: context.read<FilterSearchCubit>().state.filter.speciality,
          gender: context.read<FilterSearchCubit>().state.filter.gender,
          keyword: context.read<FilterSearchCubit>().state.filter.keyword,
        ));
      },
    );
  }

  ListView _buildInstitutesList() {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        separatorBuilder: (context, index) => SizedBox(
              height: 16.h,
            ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return InstituteItem();
        });
  }
}
