import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';

part 'teacher_info_stepper_state.dart';

class TeacherInfoStepperCubit extends Cubit<TeacherInfoStepperState> {
  TeacherInfoStepperCubit()
      : super(
          TeacherInfoStepperState(
            currentIndex: 0,
          ),
        );
  void initStepper(int step) {
    emit(
      TeacherInfoStepperState(
        currentIndex: step,
      ),
    );
  }

  void nextStep() {
    emit(
      TeacherInfoStepperState(
        currentIndex: state.currentIndex + 1,
      ),
    );
  }

  void stepBack() {
    emit(
      TeacherInfoStepperState(
        currentIndex: state.currentIndex - 1,
      ),
    );
  }
}
