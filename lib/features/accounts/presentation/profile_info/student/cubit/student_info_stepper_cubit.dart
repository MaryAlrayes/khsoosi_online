import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';

part 'student_info_stepper_state.dart';

class StudentInfoStepperCubit extends Cubit<StudentInfoStepperState> {
  StudentInfoStepperCubit()
      : super(
          StudentInfoStepperState(
            currentIndex: 0,
          ),
        );

  void nextStep() {
    emit(
      StudentInfoStepperState(
        currentIndex: state.currentIndex + 1,
      ),
    );
  }

  void stepBack() {

    emit(
      StudentInfoStepperState(
        currentIndex: state.currentIndex - 1,
       
      ),
    );
  }
}
