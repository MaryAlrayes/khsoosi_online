// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/font_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search_teacher/widgets/next_previous_btn.dart';

import '../../../../../core/utils/enums/enums.dart';

class TeachingMethodFilter extends StatelessWidget {
  final VoidCallback? onNext;
  final bool withNextBtn;

  const TeachingMethodFilter({
    Key? key,
    this.onNext,
    this.withNextBtn = true,
  }) : super(key: key);

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
                ..._buildRadioGroup(state, context),
              ],
            ),
            if (withNextBtn)
              Container(
                alignment: Alignment.centerLeft,
                child: _buildNextBtn(context),
              )
          ],
        );
      },
    );
  }

  NextPreviousBtn _buildNextBtn(BuildContext context) {
    return NextPreviousBtn(
      nextOrPrevious: NextOrPrevious.next,
      onPressed: onNext != null ? onNext! : () {},
    );
  }

  List<Widget> _buildRadioGroup(FilterSearchState state, BuildContext context) {

    return TeachingMethod.values
        .map(
          (method) => Directionality(
            textDirection: TextDirection.ltr,
            child: RadioListTile<TeachingMethod>(
              title: Text(
                method.getText(),
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 14),
              ),
              value: method,
              groupValue: state.filter.teachingMethod,
              selected: state.filter.teachingMethod==method,
              secondary: Icon(
                method == TeachingMethod.online
                    ? Icons.online_prediction
                    : Icons.person,
              ),
              onChanged: (value) {
                BlocProvider.of<FilterSearchCubit>(context)
                    .setTeachingMethod(value!);
              },
            ),
          ),
        )
        .toList();
  }

  Text _buildLabel() {
    return Text(
      'اختر طريقة التدريس:',
      style: kBlackBoldTextStyle,
    );
  }
}
