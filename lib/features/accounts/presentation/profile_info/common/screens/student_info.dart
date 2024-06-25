// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_stepper/easy_stepper.dart';
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
  final List<CountryEntity> countries;
  const StudentInfo({
    Key? key,
    required this.countries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stepsWidget = [
      StudentInfoStep1(countries: countries),
      StudentInfoStep2(countries: countries),
      StudentInfoStep3(),
    ];
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
                    _buildStepper(state, context),
                    _buildMainContent(stepsWidget, state)
                  ],
                );
              },
            ));
      }),
    );
  }

  Expanded _buildMainContent(
      List<StatelessWidget> stepsWidget, StudentInfoStepperState state) {
    return Expanded(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: stepsWidget[state.currentIndex],
        ),
      ]),
    );
  }

  Material _buildStepper(StudentInfoStepperState state, BuildContext context) {
    return Material(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(0),
        height: 80,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.white),
        child: EasyStepper(
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
          ],
          onStepReached: (index) {},
        ),
      ),
    );
  }

  EasyStep _getStep(int currentIndex, int supposedIndex) {
    return EasyStep(
      customStep: CircleAvatar(
        radius: 30,
        backgroundColor: currentIndex >= supposedIndex
            ? ColorManager.orange
            : ColorManager.gray1,
        child: currentIndex <= supposedIndex
            ? Text(
                '${supposedIndex + 1}',
                style: TextStyle(color: Colors.white),
              )
            : Icon(
                Icons.check,
                color: Colors.white,
              ),
      ),
    );
  }
}
