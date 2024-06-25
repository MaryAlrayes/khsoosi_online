import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/presentation/search_institutes/bloc/get_institutes_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_institutes/widgets/institute_item.dart';

import '../../../../../core/ui/widgets/error_widget.dart';
import '../../../../../core/ui/widgets/no_connection_widget.dart';
import '../../filter/cubit/filter_search_cubit.dart';

class SearchInstitutesScreen extends StatelessWidget {
  const SearchInstitutesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetInstitutesBloc, GetInstitutesState>(
      builder: (context, state) {
        switch (state.status) {
          case GetInstitutesStatus.loading:
            return _buildLoading();
          case GetInstitutesStatus.loadingMore:
          case GetInstitutesStatus.success:
            return _buildMainContent(state, context);
          case GetInstitutesStatus.offline:
            return _buildOffline(context);
          case GetInstitutesStatus.error:
            return _buildError(state, context);
        }
      },
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildMainContent(GetInstitutesState state, BuildContext context) {
    if (state.data.isEmpty) {
      return Center(
        child: Text('لا يوجد بيانات'),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(child: _buildInstitutesList(state, context)),
        ],
      ),
    );
  }

  NetworkErrorWidget _buildError(
      GetInstitutesState state, BuildContext context) {
    return NetworkErrorWidget(
      message: state.errorMessage,
      onPressed: () {
        BlocProvider.of<GetInstitutesBloc>(context).add(LoadInstitutesEvent(
            refresh: true, filter: _getCurrentFilter(context)));
      },
    );
  }

  NoConnectionWidget _buildOffline(BuildContext context) {
    return NoConnectionWidget(
      onPressed: () {
        BlocProvider.of<GetInstitutesBloc>(context).add(LoadInstitutesEvent(
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
              context.read<GetInstitutesBloc>().add(
                    LoadInstitutesEvent(
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

  Widget _buildInstitutesList(GetInstitutesState state, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) => SizedBox(
                  height: 16.h,
                ),
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              return InstituteItem(
                instituteEntity: state.data[index],
              );
            }),
        !state.hasReachedMax
            ? state.status == GetInstitutesStatus.success
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
