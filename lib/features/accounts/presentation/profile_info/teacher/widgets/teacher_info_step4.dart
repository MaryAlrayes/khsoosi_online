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

class TeacherInfoStep4 extends StatelessWidget {
  const TeacherInfoStep4({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'أسلوبك في تقديم الدروس:',
            style: kBlackBoldTextStyle,
          ),
           SizedBox(
            height: 8,
          ),
          Divider(color: ColorManager.gray1,),
          SizedBox(
            height: 8,
          ),
          CustomCheckBoxTile(
            label: TeachingMethod.presence.getText(),
            initValue: context
                    .read<TeacherExtraInfoCubit>()
                    .state
                    .teacherExtraInfoEntity
                    .teachHouse ??
                false,
            onChanged: (value) {
              BlocProvider.of<TeacherExtraInfoCubit>(context)
                  .setHouseMethod(value!);
            },
          ),
          SizedBox(
            height: 8,
          ),
          CustomCheckBoxTile(
            label: TeachingMethod.online.getText(),
            initValue: context
                    .read<TeacherExtraInfoCubit>()
                    .state
                    .teacherExtraInfoEntity
                    .teacheOnline ??
                false,
            onChanged: (value) {
              BlocProvider.of<TeacherExtraInfoCubit>(context)
                  .setOnlineMethod(value!);
            },
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
    return  Column(
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
