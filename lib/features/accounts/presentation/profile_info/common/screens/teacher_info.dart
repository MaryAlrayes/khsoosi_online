// ignore_for_file: public_member_api_docs, sort_constructors_first
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
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_info_step1.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_info_step10.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_info_step2.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_info_step3.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_info_step4.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_info_step5.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_info_step6.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_info_step7.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_info_step8.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/teacher/widgets/teacher_info_step9.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/get_categories_bloc.dart';

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
          create: (context) => sl.locator<GetCategoriesBloc>()..add(LoadCategoriesEvent()),
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
                    Expanded(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme:
                              ColorScheme.light(primary: ColorManager.orange),
                        ),
                        child: Stepper(
                          currentStep: state.currentIndex,
                          onStepTapped: null,
                          onStepContinue: null,
                          onStepCancel: null,
                          type: StepperType.horizontal,
                          controlsBuilder: (context, details) {
                            return Container();
                          },
                          steps: [
                            _getStep1(state.currentStep, state.currentIndex),
                            _getStep2(state.currentStep, state.currentIndex),
                            _getStep3(state.currentStep, state.currentIndex),
                            _getStep4(state.currentStep, state.currentIndex),
                            _getStep5(state.currentStep, state.currentIndex),
                            _getStep6(state.currentStep, state.currentIndex),
                            _getStep7(state.currentStep, state.currentIndex),
                            _getStep8(state.currentStep, state.currentIndex),
                            _getStep9(state.currentStep, state.currentIndex),
                         _getStep10(state.currentStep, state.currentIndex),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ));
      }),
    );
  }

  Step _getStep1(TeacherInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 0 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 0,
      title: Text(
        '',
      ),
      content: TeacherInfoStep1(
        countries: countries,
      ),
    );
  }

  Step _getStep2(TeacherInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 1 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 1,
      title: Text(
        '',
      ),
      content: TeacherInfoStep2(
        countries: countries,
      ),
    );
  }

  Step _getStep3(TeacherInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 2 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 2,
      title: Text(
        '',
      ),
      content: TeacherInfoStep3(),
    );
  }

  Step _getStep4(TeacherInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 3 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 3,
      title: Text(
        '',
      ),
      content: TeacherInfoStep4(),
    );
  }

  Step _getStep5(TeacherInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 4 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 4,
      title: Text(
        '',
      ),
      content: TeacherInfoStep5(),
    );
  }

  Step _getStep6(TeacherInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 5 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 5,
      title: Text(
        '',
      ),
      content: TeacherInfoStep6(),
    );
  }

  Step _getStep7(TeacherInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 6 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 6,
      title: Text(
        '',
      ),
      content: TeacherInfoStep7(),
    );
  }

  Step _getStep8(TeacherInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 7 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 7,
      title: Text(
        '',
      ),
      content: TeacherInfoStep8(),
    );
  }

  Step _getStep9(TeacherInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 8 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 8,
      title: Text(
        '',
      ),
      content: TeacherInfoStep9(),
    );
  }
   Step _getStep10(TeacherInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 9 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 9,
      title: Text(
        '',
      ),
      content: TeacherInfoStep10(),
    );
  }
}
