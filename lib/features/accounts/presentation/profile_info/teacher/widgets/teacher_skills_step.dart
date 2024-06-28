import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_error_message.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/core/utils/helpers/toast_utils.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/previous_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_stepper_cubit.dart';

import '../../common/widgets/multiline_field.dart';
import '../../common/widgets/skills_field.dart';

class TeacherSkillsStep extends StatelessWidget {
  const TeacherSkillsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeacherExtraInfoCubit, TeacherExtraInfoState>(
      listener: (context, state) {
        _buildListener(state, context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SkillsField(
              initalValue: context
                  .read<TeacherExtraInfoCubit>()
                  .state
                  .teacherExtraInfoEntity
                  .skills,
              onChanged: (value) {
                BlocProvider.of<TeacherExtraInfoCubit>(context)
                    .setSkills(value);
              }),
          _buildErrorMessages(),
          SizedBox(
            height: 16,
          ),
          _buildBtns(context)
        ],
      ),
    );
  }

  BlocBuilder<TeacherExtraInfoCubit, TeacherExtraInfoState>
      _buildErrorMessages() {
    return BlocBuilder<TeacherExtraInfoCubit, TeacherExtraInfoState>(
        builder: (context, state) {
      return state.errorMessage.isEmpty
          ? Container()
          : CustomErrorMessage(
              errorMessage: state.errorMessage,
            );
    });
  }

  void _buildListener(TeacherExtraInfoState state, BuildContext context) {
    if (state.teacherExtraInfoStatus == TeacherExtraInfoStatus.done) {
      ToastUtils.showSusToastMessage('تم إضافة معلوماتك بنجاح');
      BlocProvider.of<TeacherInfoStepperCubit>(context).nextStep();
    } else if (state.teacherExtraInfoStatus ==
        TeacherExtraInfoStatus.noInternet) {
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state.teacherExtraInfoStatus ==
        TeacherExtraInfoStatus.networkError) {
      showSnackbar(context, AppStrings.networkError);
    }
  }

  Widget _buildBtns(BuildContext context) {
    return BlocBuilder<TeacherExtraInfoCubit, TeacherExtraInfoState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            NextBtn(
              isLoading: state.teacherExtraInfoStatus ==
                  TeacherExtraInfoStatus.loading,
              onPressed: state.teacherExtraInfoStatus ==
                      TeacherExtraInfoStatus.loading
                  ? () {}
                  : () {
                      if (context
                          .read<TeacherExtraInfoCubit>()
                          .state
                          .teacherExtraInfoEntity
                          .skills
                          .isEmpty) {
                        showSnackbar(context, 'عليك إدخال خبراتك ومهاراتك');
                      } else {
                        BlocProvider.of<TeacherExtraInfoCubit>(context)
                            .submit(id: context.read<AuthRepo>().getUserId()!);
                      }
                    },
            ),
            SizedBox(
              height: 8,
            ),
            PreviousBtn(
              onPressed:
                  state.teacherExtraInfoStatus == TeacherExtraInfoStatus.loading
                      ? () {}
                      : () {
                          BlocProvider.of<TeacherInfoStepperCubit>(context)
                              .stepBack();
                        },
            ),
          ],
        );
      },
    );
  }
}
