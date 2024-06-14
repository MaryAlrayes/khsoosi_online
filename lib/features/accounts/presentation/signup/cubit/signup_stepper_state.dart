// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_stepper_cubit.dart';

List<SignupSteps> steps = [
  SignupSteps.userType,
  SignupSteps.name,
  SignupSteps.emailPassword
];

class SignupStepperState extends Equatable {
  final SignupSteps currentStep;
  final int currentIndex;
  final List<SignupSteps> stepsStack;
  const SignupStepperState({
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
