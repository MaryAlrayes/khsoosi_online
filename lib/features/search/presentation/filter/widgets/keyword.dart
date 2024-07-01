// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/bloc/get_teachers_bloc.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/widgets/next_previous_btn.dart';

class KeywordFilter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSearchCubit, FilterSearchState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // _buildLabel(),
                // SizedBox(
                //   height: 8.h,
                // ),
                _buildTextFieldKeyword(context),
              ],
            ),

          ],
        );
      },
    );
  }

  CustomTextField _buildTextFieldKeyword(BuildContext context) {
    return CustomTextField(
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.text,
      hintText: 'ادخل كلمة مفتاحية',
      validator: (value) {},
      initalValue: context.read<FilterSearchCubit>().state.filter.keyword,
      isObscure: false,
      onChanged: (value) {
        BlocProvider.of<FilterSearchCubit>(context).setKeyword(value);
      },
    );
  }



}
