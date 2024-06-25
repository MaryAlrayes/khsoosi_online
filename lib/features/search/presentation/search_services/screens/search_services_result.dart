// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';

import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_services/widgets/service_item.dart';

import '../../../domain/entities/search_filter_entity.dart';
import '../bloc/get_services_bloc.dart';

class SearchServicesResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetServicesBloc, GetServicesState>(
      builder: (context, state) {
        switch (state.status) {
          case GetServicesStatus.loading:
            return _buildLoading();
          case GetServicesStatus.loadingMore:
          case GetServicesStatus.success:
            return _buildMainContent(state, context);
          case GetServicesStatus.offline:
            return _buildOffline(context);
          case GetServicesStatus.error:
            return _buildError(state, context);
        }
      },
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildMainContent(GetServicesState state, BuildContext context) {
    if (state.data.isEmpty) {
      return Center(
        child: Text('لا يوجد بيانات'),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(child: _buildServicesGrid(state, context)),
        ],
      ),
    );
  }

  NetworkErrorWidget _buildError(GetServicesState state, BuildContext context) {
    return NetworkErrorWidget(
      message: state.errorMessage,
      onPressed: () {
        BlocProvider.of<GetServicesBloc>(context).add(LoadServicesEvent(
            refresh: true, filter: _getCurrentFilter(context)));
      },
    );
  }

  NoConnectionWidget _buildOffline(BuildContext context) {
    return NoConnectionWidget(
      onPressed: () {
        BlocProvider.of<GetServicesBloc>(context).add(LoadServicesEvent(
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
              context.read<GetServicesBloc>().add(
                    LoadServicesEvent(
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

  Widget _buildServicesGrid(GetServicesState state, BuildContext context) {
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
              return ServiceItem(
                serviceEntity: state.data[index],
              );
            }),
        !state.hasReachedMax
            ? state.status == GetServicesStatus.success
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
