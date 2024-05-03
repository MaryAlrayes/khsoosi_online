import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_courses/widgets/course_item.dart';

class SearchCoursesResult extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
       
            Container(child: _buildCoursesGrid()),
          ],
        ),
      ),
    );
  }



  Widget _buildCoursesGrid() {
    return MasonryGridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return CourseItem();
      },
    );
  }
}
