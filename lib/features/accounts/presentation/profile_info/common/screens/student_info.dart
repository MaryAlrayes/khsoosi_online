// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/log_out.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/student/cubit/student_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/student/cubit/student_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/phone_numbers.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/student/widgets/student_info_step1.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/student/widgets/student_info_step2.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/student/widgets/student_info_step3.dart';

import '../../../../../location/domain/entities/country_entity.dart';

class StudentInfo extends StatelessWidget {
final  List<CountryEntity> countries;
  const StudentInfo({
    Key? key,
    required this.countries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.locator<StudentInfoStepperCubit>(),
        ),
        BlocProvider(
          create: (context) => sl.locator<StudentInfoCubit>(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('إكمال معلوماتك الشخصية'),
              actions: [buildLogout()],
            ),
            body: BlocBuilder<StudentInfoStepperCubit, StudentInfoStepperState>(
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

  Step _getStep1(StudentInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 0 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 0,
      title: Text(
        '',
      ),
      content: StudentInfoStep1(countries: countries,),
    );
  }

  Step _getStep2(StudentInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 1 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 1,
      title: Text(
        '',
      ),
      content: StudentInfoStep2(countries: countries,),
    );
  }

  Step _getStep3(StudentInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 2 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 2,
      title: Text(
        '',
      ),
      content: StudentInfoStep3(),
    );
  }
}
