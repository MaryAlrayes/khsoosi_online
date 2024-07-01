// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/font_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/app_drop_down.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/widgets/next_previous_btn.dart';

import '../../../../../core/utils/enums/enums.dart';

class EducationalLevelFilter extends StatelessWidget {

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

                _buildEducationalLevelDropDown(state, context),
              ],
            ),

          ],
        );
      },
    );
  }



  AppDropDown<EducationalLevel> _buildEducationalLevelDropDown(
      FilterSearchState state, BuildContext context) {
    return AppDropDown<EducationalLevel>(
        hintText: 'المرحلة الدراسية',
        items: EducationalLevel.values
            .map((e) => DropdownMenuItem(
                  child: Text(e.getTextForDropDown(),style: TextStyle(fontSize: 14),),
                  value: e,
                ))
            .toList(),
        icon: Icon(
          Icons.school,
          color: ColorManager.black,
        ),
        initSelectedValue: state.filter.educationalLevel,
        onChanged: (value) {
          BlocProvider.of<FilterSearchCubit>(context).setEducationLevel(value);
        });
  }

  Text _buildLabel() {
    return Text(
      'اختر المرحلة الدراسية:',
      style: kBlackBoldTextStyle,
    );
  }
}
