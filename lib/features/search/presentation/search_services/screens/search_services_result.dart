// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_services/widgets/service_item.dart';

import '../../../domain/entities/search_filter_entity.dart';

class SearchServicesResult extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(child: _buildServicesGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesGrid() {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        separatorBuilder: (context, index) => SizedBox(
              height: 16.h,
            ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ServiceItem();
        });

  }
}
