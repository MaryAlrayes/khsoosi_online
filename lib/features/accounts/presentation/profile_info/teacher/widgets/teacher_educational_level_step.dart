import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_stepper_cubit.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/educational_level.dart';

import '../../../../../../core/ui/widgets/custom_check_box_tile.dart';
import '../../common/widgets/educational_level_selector.dart';

class TeacherEducationalLevelStep extends StatelessWidget {
  const TeacherEducationalLevelStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EducationalLevelSelector(
          elementryInitialValue: context
                  .read<TeacherExtraInfoCubit>()
                  .state
                  .teacherExtraInfoEntity
                  .teachElementry ??
              false,
          preparatoryInitialValue: context
                  .read<TeacherExtraInfoCubit>()
                  .state
                  .teacherExtraInfoEntity
                  .teachPreparatory ??
              false,
          secondaryInitialValue: context
                  .read<TeacherExtraInfoCubit>()
                  .state
                  .teacherExtraInfoEntity
                  .teachSecondary ??
              false,
          universityInitialValue: context
                  .read<TeacherExtraInfoCubit>()
                  .state
                  .teacherExtraInfoEntity
                  .teachUniversity ??
              false,
          onEelementryChanged: (value) {
            BlocProvider.of<TeacherExtraInfoCubit>(context)
                .setElementry(value!);
          },
          onpreparatoryChanged: (value) {
            BlocProvider.of<TeacherExtraInfoCubit>(context)
                .setPreparatory(value!);
          },
          onSecondaryChanged: (value) {
            BlocProvider.of<TeacherExtraInfoCubit>(context)
                .setSecondary(value!);
          },
          onUniversityChanged: (value) {
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
    return Column(
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
