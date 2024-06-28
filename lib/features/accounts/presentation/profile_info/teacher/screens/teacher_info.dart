// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/log_out.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/cubit/teacher_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_phones_step.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_upload_certificates_step.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_upload_image_step.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_general_info_step.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_social_media_step.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_teaching_method_step.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_educational_level_step.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_address_step.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_categories_step.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_certificates_step.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_skills_step.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_categories_bloc.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_universities_bloc.dart';

import '../widgets/teacher_location_step.dart';
import '../widgets/teacher_universities_courses.dart';

class TeacherInfo extends StatelessWidget {
  final List<CountryEntity> countries;

  final bool hasFinishedFirstInfo;
  const TeacherInfo({
    Key? key,
    required this.countries,
    required this.hasFinishedFirstInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.locator<TeacherInfoStepperCubit>()
            ..initStepper(hasFinishedFirstInfo ? 3 : 0),
        ),
        BlocProvider(
          create: (context) => sl.locator<TeacherInfoCubit>(),
        ),
        BlocProvider(
          create: (context) => sl.locator<TeacherExtraInfoCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              sl.locator<GetCategoriesBloc>()..add(LoadCategoriesEvent()),
        ),
        BlocProvider(
          create: (context) =>
              sl.locator<GetUniversitiesBloc>()..add(LoadUniversitiesEvent()),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('إكمال معلوماتك الشخصية'),
              actions: [buildLogout()],
            ),
            body: BlocBuilder<TeacherInfoStepperCubit, TeacherInfoStepperState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildStepper(state, context),
                    _buildMainContent(state, context)
                  ],
                );
              },
            ));
      }),
    );
  }

  Expanded _buildMainContent(
      TeacherInfoStepperState state, BuildContext context) {
    return Expanded(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: getSteps(context)[state.currentIndex],
        ),
      ]),
    );
  }

  Widget _buildStepper(TeacherInfoStepperState state, BuildContext context) {
    return BlocBuilder<TeacherExtraInfoCubit, TeacherExtraInfoState>(
      builder: (context, teacherExtraInfoState) {
        return Material(
          elevation: 2,
          child: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(0),
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: EasyStepper(
              key: Key(
                  "teacherInfoSuperkey-" + getSteps(context).length.toString()),
              activeStep: state.currentIndex,
              internalPadding: 0,
              showLoadingAnimation: false,
              stepRadius: 24,
              showStepBorder: false,
              enableStepTapping: false,
              padding: EdgeInsets.all(0),
              fitWidth: true,
              alignment: Alignment.centerRight,
              stepAnimationDuration: Duration(milliseconds: 500),
              steps: [
                _getStep(state.currentIndex, 0),
                _getStep(state.currentIndex, 1),
                _getStep(state.currentIndex, 2),
                _getStep(state.currentIndex, 3),
                _getStep(state.currentIndex, 4),
                _getStep(state.currentIndex, 5),
                _getStep(state.currentIndex, 6),
                _getStep(state.currentIndex, 7),
                _getStep(state.currentIndex, 8), //done
                if (teacherExtraInfoState
                            .teacherExtraInfoEntity.teachUniversity ==
                        null ||
                    teacherExtraInfoState
                            .teacherExtraInfoEntity.teachUniversity ==
                        false) ...[

                  _getStep(state.currentIndex, 9), //upload  certificate
                  _getStep(state.currentIndex, 10), //location
                  _getStep(state.currentIndex, 11), //picture
                ],
                if (teacherExtraInfoState
                            .teacherExtraInfoEntity.teachUniversity !=
                        null &&
                    teacherExtraInfoState
                            .teacherExtraInfoEntity.teachUniversity ==
                        true) ...[
                  _getStep(state.currentIndex, 9), //upload universities
                  _getStep(state.currentIndex, 10), //upload  certificate
                  _getStep(state.currentIndex, 11), //location
                  _getStep(state.currentIndex, 12), //picture
                ],
              ],
              onStepReached: (index) {},
            ),
          ),
        );
      },
    );
  }

  EasyStep _getStep(int currentIndex, int stepIndex) {
    return EasyStep(
      customStep: CircleAvatar(
        radius: 30,
        backgroundColor: currentIndex >= stepIndex
            ? ColorManager.orange
            : ColorManager.gray1,
        child: currentIndex <= stepIndex
            ? Text(
                '${stepIndex + 1}',
                style: TextStyle(color: Colors.white),
              )
            : Icon(
                Icons.check,
                color: Colors.white,
              ),
      ),
    );
  }

  List<Widget> getSteps(BuildContext context) {
    return [
      TeacherPhonesStep(countries: countries),
      TeacherGeneralInfoStep(countries: countries),
      TeacherSocialMediaStep(),
      TeacherTeachingMethodStep(),
      TeacherEducationalLevelStep(),
      TeacherAddressStep(),
      TeacherCategoriesStep(),
      TeacherCertificatesStep(),
      TeacherSkillsStep(),
      if (context
                  .read<TeacherExtraInfoCubit>()
                  .state
                  .teacherExtraInfoEntity
                  .teachUniversity !=
              null &&
          context
                  .read<TeacherExtraInfoCubit>()
                  .state
                  .teacherExtraInfoEntity
                  .teachUniversity ==
              true)
        TeacherUniversitiesCourses(),
      TeacherUploadCertificatesStep(),
      TeacherLocationStep(),
      TeacherUploadImageStep(),
    ];
  }
}
