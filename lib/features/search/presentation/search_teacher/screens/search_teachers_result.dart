// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/bloc/get_teachers_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/widgets/teacher_item.dart';

class SearchTeachersResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTeachersBloc, GetTeachersState>(
      builder: (context, state) {
        switch (state.status) {
          case GetTeachersStatus.loading:
            return _buildLoading();
          case GetTeachersStatus.loadingMore:
          case GetTeachersStatus.success:
            return _buildMainContent(state, context);
          case GetTeachersStatus.offline:
            return _buildOffline(context);
          case GetTeachersStatus.error:
            return _buildError(state, context);
        }
      },
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildMainContent(GetTeachersState state, BuildContext context) {
    if (state.data.isEmpty) {
      return Center(
        child: Text('لا يوجد بيانات'),
      );
    }
    return SingleChildScrollView(
      child:
             _buildTeachersGrid(state, context),


    );
  }

  NetworkErrorWidget _buildError(GetTeachersState state, BuildContext context) {
    return NetworkErrorWidget(
      message: state.errorMessage,
      onPressed: () {
        BlocProvider.of<GetTeachersBloc>(context).add(LoadTeachersEvent(
            refresh: true, filter: _getCurrentFilter(context)));
      },
    );
  }

  NoConnectionWidget _buildOffline(BuildContext context) {
    return NoConnectionWidget(
      onPressed: () {
        BlocProvider.of<GetTeachersBloc>(context).add(LoadTeachersEvent(
            refresh: true, filter: _getCurrentFilter(context)));
      },
    );
  }

  Widget _buildLoadMoreBtn(BuildContext context) {

    return Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              context.read<GetTeachersBloc>().add(
                    LoadTeachersEvent(
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

  Widget _buildTeachersGrid(GetTeachersState state, BuildContext context) {
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
            return TeacherItem(
              teacherEntity: state.data[index],
            );
          },
        ),
        !state.hasReachedMax
            ? state.status == GetTeachersStatus.success
                ? _buildLoadMoreBtn(context)
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const CircularProgressIndicator(),
                    ),
                  )
            : Container()
      ],
    );
  }

  SearchFilterEntity _getCurrentFilter(BuildContext context) {
    return context.read<FilterSearchCubit>().state.filter;
  }
}
