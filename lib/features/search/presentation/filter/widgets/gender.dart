// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/widgets/next_previous_btn.dart';

class GenderFilter extends StatelessWidget {

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

                ..._buildRadioGroup(state, context),
              ],
            ),

          ],
        );
      },
    );
  }


  List<Widget> _buildRadioGroup(FilterSearchState state, BuildContext context) {
    return Gender.values
        .map(
          (gender) => Directionality(
            textDirection: TextDirection.ltr,
            child: RadioListTile<Gender>(
              title: Text(
                gender.getText(),
                textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14),
              ),
              value: gender,
              groupValue: state.filter.gender,
              selected: state.filter.gender==gender,
              secondary: Icon(
                gender == Gender.male ? Icons.male : Icons.female,

              ),
              onChanged: (value) {
                BlocProvider.of<FilterSearchCubit>(context).setGender(value);
              },
            ),
          ),
        )
        .toList();
  }

  Text _buildLabel() {
    return Text(
      'اختر جنس المدرس :',
      style: kBlackBoldTextStyle,
    );
  }
}
