import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';

part 'institute_info_stepper_state.dart';

class InstituteInfoStepperCubit extends Cubit<InstituteInfoStepperState> {
    InstituteInfoStepperCubit()
      : super(
          InstituteInfoStepperState(
             currentIndex: 0,
              ),
        );
  void initStepper(int step) {
    emit(
      InstituteInfoStepperState(
       currentIndex: step,
         ),
    );
  }

  void nextStep() {
   emit(
      InstituteInfoStepperState(
       currentIndex: state.currentIndex + 1,

      ),
    );
  }

  void stepBack() {

    emit(
      InstituteInfoStepperState(
        currentIndex: state.currentIndex - 1,
       
      ),
    );
  }
}
