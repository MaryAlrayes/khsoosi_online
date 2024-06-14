part of 'student_info_stepper_cubit.dart';

List<StudentInfoStepperSteps> steps = [
  StudentInfoStepperSteps.phones,
  StudentInfoStepperSteps.general,
  StudentInfoStepperSteps.picture
];


 class StudentInfoStepperState extends Equatable {
   final StudentInfoStepperSteps currentStep;
  final int currentIndex;
  final List<StudentInfoStepperSteps> stepsStack;
  const StudentInfoStepperState({
    required this.currentStep,
    required this.currentIndex,
    required this.stepsStack,
  });

  @override
  List<Object> get props => [
        currentStep,
        stepsStack,
      ];

}

