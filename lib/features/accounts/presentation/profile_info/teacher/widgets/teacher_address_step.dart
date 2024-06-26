import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/multiline_field.dart';

import '../../common/widgets/address_field.dart';

class TeacherAddressStep extends StatelessWidget {
  const TeacherAddressStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AddressField(
          initValue: context
                  .read<TeacherExtraInfoCubit>()
                  .state
                  .teacherExtraInfoEntity
                  .address ??
              '',
          onPressed: (value) {
            BlocProvider.of<TeacherExtraInfoCubit>(context).setAddress(value);
          },
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
