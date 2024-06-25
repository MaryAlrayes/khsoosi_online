import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_courses/bloc/get_courses_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_courses/widgets/course_item.dart';

class SearchCoursesResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCoursesBloc, GetCoursesState>(
      builder: (context, state) {
        switch (state.status) {
          case GetCoursesStatus.loading:
            return _buildLoading();
          case GetCoursesStatus.loadingMore:
          case GetCoursesStatus.success:
            return _buildMainContent(state, context);
          case GetCoursesStatus.offline:
            return _buildOffline(context);
          case GetCoursesStatus.error:
            return _buildError(state, context);
        }
      },
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildMainContent(GetCoursesState state, BuildContext context) {
    if (state.data.isEmpty) {
      return Center(
        child: Text('لا يوجد بيانات'),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(child: _buildCoursesGrid(state, context)),
        ],
      ),
    );
  }

  NetworkErrorWidget _buildError(GetCoursesState state, BuildContext context) {
    return NetworkErrorWidget(
      message: state.errorMessage,
      onPressed: () {
        BlocProvider.of<GetCoursesBloc>(context).add(LoadCoursesEvent(
            refresh: true, filter: _getCurrentFilter(context)));
      },
    );
  }

  NoConnectionWidget _buildOffline(BuildContext context) {
    return NoConnectionWidget(
      onPressed: () {
        BlocProvider.of<GetCoursesBloc>(context).add(LoadCoursesEvent(
            refresh: true, filter: _getCurrentFilter(context)));
      },
    );
  }

  Widget _buildLoadMoreBtn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              context.read<GetCoursesBloc>().add(
                    LoadCoursesEvent(
                      filter: _getCurrentFilter(context),
                    ),
                  );
            },
            child: Text(
              'تحميل المزيد',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height:70,
        )
      ],
    );
  }

  Widget _buildCoursesGrid(GetCoursesState state, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MasonryGridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
          ),
          itemCount: state.data.length,
          itemBuilder: (context, index) {
            return CourseItem(courseEntity: state.data[index]);
          },
        ),
        !state.hasReachedMax
            ? state.status == GetCoursesStatus.success
                ? _buildLoadMoreBtn(context)
                : Center(
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ))
            : Container()
      ],
    );
  }

  SearchFilterEntity _getCurrentFilter(BuildContext context) {
    return context.read<FilterSearchCubit>().state.filter;
  }
}
