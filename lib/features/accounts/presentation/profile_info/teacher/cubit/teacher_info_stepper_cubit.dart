import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';

part 'teacher_info_stepper_state.dart';

class TeacherInfoStepperCubit extends Cubit<TeacherInfoStepperState> {
  TeacherInfoStepperCubit()
      : super(
          TeacherInfoStepperState(
              currentStep: TeacherInfoStepperSteps.phones,
              currentIndex: 0,
              stepsStack: [
                TeacherInfoStepperSteps.phones,

              ]),
        );
  void initStepper(int step) {
    emit(
      TeacherInfoStepperState(
        currentStep: steps[step],
        currentIndex: step,
        stepsStack: steps.getRange(0, step+1).toList(),
      ),
    );
  }

  void nextStep() {
    List<TeacherInfoStepperSteps> newStack = List.from(state.stepsStack);
    newStack.add(steps[state.currentIndex + 1]);
    emit(
      TeacherInfoStepperState(
        currentStep: steps[state.currentIndex + 1],
        currentIndex: state.currentIndex + 1,
        stepsStack: newStack,
      ),
    );
  }

  void stepBack() {
    List<TeacherInfoStepperSteps> newStack = List.from(state.stepsStack);
    newStack.removeLast();
    final newCurrentStep = newStack[newStack.length - 1];

    emit(
      TeacherInfoStepperState(
        currentStep: newCurrentStep,
        currentIndex: state.currentIndex - 1,
        stepsStack: newStack,
      ),
    );
  }
}
