part of 'teacher_info_stepper_cubit.dart';

List<TeacherInfoStepperSteps> steps = [
  TeacherInfoStepperSteps.phones,
  TeacherInfoStepperSteps.general,
  TeacherInfoStepperSteps.social_media,
  TeacherInfoStepperSteps.teachingMethod,
  TeacherInfoStepperSteps.educationalLevel,
  TeacherInfoStepperSteps.address,
  TeacherInfoStepperSteps.categories,
  TeacherInfoStepperSteps.certificates,
  TeacherInfoStepperSteps.skills,
  TeacherInfoStepperSteps.location,
  TeacherInfoStepperSteps.picture
];

class TeacherInfoStepperState extends Equatable {
  final TeacherInfoStepperSteps currentStep;
  final int currentIndex;
  final List<TeacherInfoStepperSteps> stepsStack;
  const TeacherInfoStepperState({
    required this.currentStep,
    required this.currentIndex,
    required this.stepsStack,
  });

  @override
  List<Object> get props => [currentStep, stepsStack, currentIndex];
}
