import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';

part 'institute_info_stepper_state.dart';

class InstituteInfoStepperCubit extends Cubit<InstituteInfoStepperState> {
    InstituteInfoStepperCubit()
      : super(
          InstituteInfoStepperState(
              currentStep: InstituteInfoStepperSteps.phones,
              currentIndex: 0,
              stepsStack: [
                InstituteInfoStepperSteps.phones,

              ]),
        );
  void initStepper(int step) {
    emit(
      InstituteInfoStepperState(
        currentStep: steps[step],
        currentIndex: step,
        stepsStack: steps.getRange(0, step+1).toList(),
      ),
    );
  }

  void nextStep() {
    List<InstituteInfoStepperSteps> newStack = List.from(state.stepsStack);
    newStack.add(steps[state.currentIndex + 1]);
    emit(
      InstituteInfoStepperState(
        currentStep: steps[state.currentIndex + 1],
        currentIndex: state.currentIndex + 1,
        stepsStack: newStack,
      ),
    );
  }

  void stepBack() {
    List<InstituteInfoStepperSteps> newStack = List.from(state.stepsStack);
    newStack.removeLast();
    final newCurrentStep = newStack[newStack.length - 1];

    emit(
      InstituteInfoStepperState(
        currentStep: newCurrentStep,
        currentIndex: state.currentIndex - 1,
        stepsStack: newStack,
      ),
    );
  }
}
