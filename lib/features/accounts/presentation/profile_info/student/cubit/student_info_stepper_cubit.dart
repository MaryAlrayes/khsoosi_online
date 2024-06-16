import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';

part 'student_info_stepper_state.dart';

class StudentInfoStepperCubit extends Cubit<StudentInfoStepperState> {
  StudentInfoStepperCubit()
      : super(
          StudentInfoStepperState(
              currentStep: StudentInfoStepperSteps.phones,
              currentIndex: 0,
              stepsStack: [StudentInfoStepperSteps.phones]),
        );

  void nextStep() {
    List<StudentInfoStepperSteps> newStack = List.from(state.stepsStack);
    newStack.add(steps[state.currentIndex + 1]);
    emit(
      StudentInfoStepperState(
        currentStep: steps[state.currentIndex + 1],
        currentIndex: state.currentIndex + 1,
        stepsStack: newStack,
      ),
    );
  }

  void stepBack() {
    List<StudentInfoStepperSteps> newStack = List.from(state.stepsStack);
    newStack.removeLast();
    final newCurrentStep = newStack[newStack.length - 1];

    emit(
      StudentInfoStepperState(
        currentStep: newCurrentStep,
        currentIndex: state.currentIndex - 1,
        stepsStack: newStack,
      ),
    );
  }
}
