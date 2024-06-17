import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/autocomplete_text_field.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/categories_picker.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_stepper_cubit.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_categories_bloc.dart';

class TeacherInfoStep7 extends StatelessWidget {
  TeacherInfoStep7({super.key});
  late TextEditingController specialityTextEditingController;
  late FocusNode specialityFocusNode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'المجالات التي تقدم دروس و دورات ضمنها',
            style: kBlackBoldTextStyle,
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: ColorManager.gray1,
          ),
          SizedBox(
            height: 32,
          ),
          RichText(
            text:
                TextSpan(style: DefaultTextStyle.of(context).style, children: [
              TextSpan(
                text: 'تخصصاتك',
                style: kBlackBoldTextStyle,
              ),
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ]),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'قم بإدخال تخصصاتك الصحيحة لنربطك مع طلبة مهتمين بخدماتك',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 16,
          ),
          BlocBuilder<TeacherExtraInfoCubit, TeacherExtraInfoState>(
            builder: (context, state) {
              return CategoriesPicker(
                  selectedCategories: state.teacherExtraInfoEntity.categories,
                  onDelete: (value) {
                    BlocProvider.of<TeacherExtraInfoCubit>(context)
                        .deleteCategory(value);
                  },
                  onSelect: (value) {
                    BlocProvider.of<TeacherExtraInfoCubit>(context)
                        .addCategory(value);
                  });
            },
          ),
       
          _buildBtns(context)
        ],
      ),
    );
  }

  Widget _buildBtns(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        NextBtn(
          onPressed: () {
            if (context
                .read<TeacherExtraInfoCubit>()
                .state
                .teacherExtraInfoEntity
                .categories
                .isEmpty) {
              showSnackbar(context, 'عليك إدخال تخصص واحد على الأقل');
            } else if (context
                    .read<TeacherExtraInfoCubit>()
                    .state
                    .teacherExtraInfoEntity
                    .categories
                    .length >
                8) {
              showSnackbar(context, 'لا يمكنك إدخال أكثر من 8 اختصاصات');
            } else {
              BlocProvider.of<TeacherInfoStepperCubit>(context).nextStep();
            }
          },
        ),
        SizedBox(
          height: 8,
        ),
        PreviousBtn(
          onPressed: () {
            BlocProvider.of<TeacherInfoStepperCubit>(context).stepBack();
          },
        ),
      ],
    );
  }
}
