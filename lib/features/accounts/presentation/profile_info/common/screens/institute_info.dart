import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/log_out.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/institute_extra_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/institute_info_stepper_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/cubit/intitute_info_cubit.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/widgets/institute_info_step1.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/widgets/institute_info_step2.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/widgets/institute_info_step3.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/widgets/institute_info_step4.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/widgets/institute_info_step5.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/institute/widgets/institute_info_step6.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';
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
    var stepsWidget = [
      InstituteInfoStep1(countries: countries),
      InstituteInfoStep2(countries: countries),
      InstituteInfoStep3(),
      InstituteInfoStep4(),
      InstituteInfoStep5(),
      InstituteInfoStep6(),
    ];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.locator<InstituteInfoStepperCubit>()
            ..initStepper(hasFinishedFirstInfo ? 2 : 0),
        ),
        BlocProvider(
          create: (context) => sl.locator<IntituteInfoCubit>(),
        ),
        BlocProvider(
          create: (context) => sl.locator<InstituteExtraInfoCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              sl.locator<GetCategoriesBloc>()..add(LoadCategoriesEvent()),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('إكمال معلوماتك الشخصية'),
              actions: [buildLogout()],
            ),
            body: BlocBuilder<InstituteInfoStepperCubit,
                InstituteInfoStepperState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildStepper(state),
                    _buildMainContent(stepsWidget, state)
                  ],
                );
              },
            ));
      }),
    );
  }

  Expanded _buildMainContent(
      List<StatelessWidget> stepsWidget, InstituteInfoStepperState state) {
    return Expanded(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: stepsWidget[state.currentIndex],
        ),
      ]),
    );
  }

  Material _buildStepper(InstituteInfoStepperState state) {
    return Material(
      elevation: 2,
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(0),
        height: 80,
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
            _getStep(state.currentIndex, 3),
            _getStep(state.currentIndex, 4),
            _getStep(state.currentIndex, 5),
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
