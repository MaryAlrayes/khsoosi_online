import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';

part 'signup_stepper_state.dart';

class SignupStepperCubit extends Cubit<SignupStepperState> {
  SignupStepperCubit()
      : super(
          SignupStepperState(
            currentIndex: 0,
          ),
        );

  void nextStep() {
    emit(
      SignupStepperState(
        currentIndex: state.currentIndex + 1,
      ),
    );
  }

  void stepBack() {
    emit(
      SignupStepperState(
        currentIndex: state.currentIndex - 1,
      ),
    );
  }
}
