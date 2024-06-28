part of 'student_info_stepper_cubit.dart';



 class StudentInfoStepperState extends Equatable {
  final int currentIndex;
  const StudentInfoStepperState({
    required this.currentIndex,

  });

  @override
  List<Object> get props => [
      currentIndex
      ];

}

