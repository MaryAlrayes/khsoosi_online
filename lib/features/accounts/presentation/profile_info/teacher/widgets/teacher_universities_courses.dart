import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/common_widgets/next_btn.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_stepper_cubit.dart';
import 'package:khosousi_online/features/location/presentation/pages/location_map_screen.dart';

import '../../../../../../core/managers/string_manager.dart';
import '../../../../../../core/utils/helpers/snackbar.dart';
import '../../../../../../core/utils/helpers/toast_utils.dart';
import '../../common/widgets/universities_picker.dart';
import '../../common/widgets/university_courses.dart';

import 'package:khosousi_online/core/locator/service_locator.dart' as sl;

import '../cubit/upload_universities_cubit.dart';

class TeacherUniversitiesCourses extends StatelessWidget {
  const TeacherUniversitiesCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<UploadUniversitiesCubit>(),
      child: Builder(builder: (context) {
        return SingleChildScrollView(
            child:
                BlocListener<UploadUniversitiesCubit, UploadUniversitiesState>(
          listener: (context, state) {
            _buildListener(state, context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<UploadUniversitiesCubit, UploadUniversitiesState>(
                builder: (context, state) {
                  return UniversitiesPicker(
                    selectedUniversities: state.universities,
                    onSelect: (value) {
                      BlocProvider.of<UploadUniversitiesCubit>(context)
                          .addUniversity(value);
                    },
                    onDelete: (value) {
                      BlocProvider.of<UploadUniversitiesCubit>(context)
                          .deleteUniversity(value);
                    },
                  );
                },
              ),
              SizedBox(height: 16),
              UniversityCourses(
                initialValue:
                    context.read<UploadUniversitiesCubit>().state.courses,
                onChanged: (value) {
                  BlocProvider.of<UploadUniversitiesCubit>(context)
                      .changeCourses(value);
                },
              ),
              SizedBox(height: 16),
              _buildBtns(context)
            ],
          ),
        ));
      }),
    );
  }

  void _buildListener(UploadUniversitiesState state, BuildContext context) {
    if (state.uploadUniversitiesStatus == UploadUniversitiesStatus.done) {
      ToastUtils.showSusToastMessage('تم رفع المعلومات بنجاح');
      BlocProvider.of<TeacherInfoStepperCubit>(context).nextStep();
    } else if (state.uploadUniversitiesStatus ==
        UploadUniversitiesStatus.noInternet) {
      showSnackbar(context, AppStrings.noInternetConnectionMessage);
    } else if (state.uploadUniversitiesStatus ==
        UploadUniversitiesStatus.networkError) {
      showSnackbar(context, AppStrings.networkError);
    }
  }

  Widget _buildBtns(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<UploadUniversitiesCubit, UploadUniversitiesState>(
          builder: (context, state) {
            return NextBtn(
              isLoading: state.uploadUniversitiesStatus == UploadUniversitiesStatus.loading,
              onPressed: state.uploadUniversitiesStatus == UploadUniversitiesStatus.loading
                  ? () {}
                  : () {
                      BlocProvider.of<TeacherInfoStepperCubit>(context)
                          .nextStep();
                    },
            );
          },
        ),
      ],
    );
  }
}
