import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/log_out.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/institute_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/intitute_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/widgets/institute_info_step1.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/widgets/institute_info_step2.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/widgets/institute_info_step3.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/widgets/institute_info_step4.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/widgets/institute_info_step5.dart';
import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';
import '../../../../../../shared_features/presentation/bloc/get_categories_bloc.dart';
class InstituteInfo extends StatelessWidget {
 final List<CountryEntity> countries;

  final bool hasFinishedFirstInfo;
  const InstituteInfo({
    Key? key,
    required this.countries,
    required this.hasFinishedFirstInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.locator<InstituteInfoStepperCubit>()
            ..initStepper(hasFinishedFirstInfo ? 2 : 0),
        ),
        BlocProvider(
          create: (context) => sl.locator<IntituteInfoCubit>(),
        ),
        //  BlocProvider(
        //   create: (context) => sl.locator<TeacherExtraInfoCubit>(),
        // ),
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
            body: BlocBuilder<InstituteInfoStepperCubit, InstituteInfoStepperState>(
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

  Step _getStep1(InstituteInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 0 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 0,
      title: Text(
        '',
      ),
      content: InstituteInfoStep1(
        countries: countries,
      ),
    );
  }

  Step _getStep2(InstituteInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 1 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 1,
      title: Text(
        '',
      ),
      content: InstituteInfoStep2(
        countries: countries,
      ),
    );
  }

  Step _getStep3(InstituteInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 2 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 2,
      title: Text(
        '',
      ),
      content: InstituteInfoStep3(),
    );
  }

  Step _getStep4(InstituteInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 3 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 3,
      title: Text(
        '',
      ),
      content: InstituteInfoStep4(),
    );
  }

  Step _getStep5(InstituteInfoStepperSteps currentStep, int currentIndex) {
    return Step(
      state: currentIndex > 4 ? StepState.complete : StepState.indexed,
      isActive: currentIndex >= 4,
      title: Text(
        '',
      ),
      content: InstituteInfoStep5(),
    );
  }

}
