part of 'teacher_info_stepper_cubit.dart';

class TeacherInfoStepperState extends Equatable {
  final int currentIndex;
  const TeacherInfoStepperState({

    required this.currentIndex,
  });

  @override
  List<Object> get props => [ currentIndex];
}
