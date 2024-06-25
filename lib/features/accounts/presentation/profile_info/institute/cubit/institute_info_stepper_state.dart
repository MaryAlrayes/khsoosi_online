part of 'institute_info_stepper_cubit.dart';

List<InstituteInfoStepperSteps> steps = [
  InstituteInfoStepperSteps.phones,
  InstituteInfoStepperSteps.general,
  InstituteInfoStepperSteps.nameAboutAddress,
  InstituteInfoStepperSteps.categories,
  InstituteInfoStepperSteps.location,
  InstituteInfoStepperSteps.picture
];

class InstituteInfoStepperState extends Equatable {
  final InstituteInfoStepperSteps currentStep;
  final int currentIndex;
  final List<InstituteInfoStepperSteps> stepsStack;
  const InstituteInfoStepperState({
    required this.currentStep,
    required this.currentIndex,
    required this.stepsStack,
  });

  @override
  List<Object> get props => [currentStep, stepsStack, currentIndex];
}
