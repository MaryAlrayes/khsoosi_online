import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_stepper_state.dart';

class FilterStepperCubit extends Cubit<FilterStepperState> {
  FilterStepperCubit() : super(FilterStepperState(currentStep: 0));
  void nextStep() {
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void previousStep() {
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void setStep(int step) {
    emit(state.copyWith(currentStep: step));
  }
}
