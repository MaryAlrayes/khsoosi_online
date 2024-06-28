import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_check_box_tile.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_stepper_cubit.dart';

import '../../common/widgets/teaching_method_selector.dart';

class TeacherTeachingMethodStep extends StatelessWidget {
  const TeacherTeachingMethodStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TeachingMethodSelector(
            onOnlineChanged: (value) {
              BlocProvider.of<TeacherExtraInfoCubit>(context)
                  .setOnlineMethod(value!);
            },
            onPresenceChanged: (value) {
              BlocProvider.of<TeacherExtraInfoCubit>(context)
                  .setHouseMethod(value!);
            },
            onlineInitialValue: context
                    .read<TeacherExtraInfoCubit>()
                    .state
                    .teacherExtraInfoEntity
                    .teacheOnline ??
                false,
            presenceInitialValue: context
                    .read<TeacherExtraInfoCubit>()
                    .state
                    .teacherExtraInfoEntity
                    .teachHouse ??
                false,
          ),
          SizedBox(
            height: 32,
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
            BlocProvider.of<TeacherInfoStepperCubit>(context).nextStep();
          },
        ),
      ],
    );
  }
}
