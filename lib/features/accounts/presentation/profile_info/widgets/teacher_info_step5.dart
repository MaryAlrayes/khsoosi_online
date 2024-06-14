import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/cubit/teacher_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/cubit/teacher_info_stepper_cubit.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/educational_level.dart';

import '../../../../../core/ui/widgets/custom_check_box_tile.dart';

class TeacherInfoStep5 extends StatelessWidget {
  const TeacherInfoStep5({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'المراحل الدراسية التي تقدم لها الدروس: ',
          style: kBlackBoldTextStyle,
        ),SizedBox(
            height: 8,
          ),
          Divider(color: ColorManager.gray1,),
          SizedBox(
            height: 8,
          ),

        CustomCheckBoxTile(
          label: EducationalLevel.elementry.getTextForDispalay(),
          initValue: context
                  .read<TeacherExtraInfoCubit>()
                  .state
                  .teacherExtraInfoEntity
                  .teachElementry ??
              false,
          onChanged: (value) {
            BlocProvider.of<TeacherExtraInfoCubit>(context)
                .setElementry(value!);
          },
        ),
        SizedBox(
          height: 8,
        ),
        CustomCheckBoxTile(
          label: EducationalLevel.preparatory.getTextForDispalay(),
          initValue: context
                  .read<TeacherExtraInfoCubit>()
                  .state
                  .teacherExtraInfoEntity
                  .teachPreparatory ??
              false,
          onChanged: (value) {
            BlocProvider.of<TeacherExtraInfoCubit>(context)
                .setPreparatory(value!);
          },
        ),
        SizedBox(
          height: 8,
        ),
        CustomCheckBoxTile(
          label: EducationalLevel.secondary.getTextForDispalay(),
          initValue: context
                  .read<TeacherExtraInfoCubit>()
                  .state
                  .teacherExtraInfoEntity
                  .teachSecondary ??
              false,
          onChanged: (value) {
            BlocProvider.of<TeacherExtraInfoCubit>(context)
                .setSecondary(value!);
          },
        ),
        SizedBox(
          height: 8,
        ),
        CustomCheckBoxTile(
          label: EducationalLevel.university.getTextForDispalay(),
          initValue: context
                  .read<TeacherExtraInfoCubit>()
                  .state
                  .teacherExtraInfoEntity
                  .teachUniversity ??
              false,
          onChanged: (value) {
            BlocProvider.of<TeacherExtraInfoCubit>(context)
                .setUniversity(value!);
          },
        ),
        SizedBox(
          height: 32,
        ),
        _buildBtns(context)
      ],
    );
  }

  Widget _buildBtns(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            NextBtn(
              onPressed: () {
                BlocProvider.of<TeacherInfoStepperCubit>(context).nextStep();
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
