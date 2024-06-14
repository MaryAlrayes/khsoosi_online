import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';

part 'signup_stepper_state.dart';

class SignupStepperCubit extends Cubit<SignupStepperState> {
  SignupStepperCubit()
      : super(
          SignupStepperState(
              currentStep: SignupSteps.userType,
              currentIndex: 0,
              stepsStack: [SignupSteps.userType]),
        );

  void nextStep() {
    List<SignupSteps> newStack = List.from(state.stepsStack);
    newStack.add(steps[state.currentIndex + 1]);
    emit(
      SignupStepperState(
        currentStep: steps[state.currentIndex + 1],
        currentIndex: state.currentIndex + 1,
        stepsStack: newStack,
      ),
    );
  }

  void stepBack() {
    List<SignupSteps> newStack = List.from(state.stepsStack);
    newStack.removeLast();
    final newCurrentStep = newStack[newStack.length - 1];

    emit(
      SignupStepperState(
        currentStep: newCurrentStep,
        currentIndex: state.currentIndex - 1,
        stepsStack: newStack,
      ),
    );
  }
  
}
