part of 'institute_info_stepper_cubit.dart';

class InstituteInfoStepperState extends Equatable {

  final int currentIndex;
  const InstituteInfoStepperState({
    required this.currentIndex,
     });

  @override
  List<Object> get props => [ currentIndex];
}
