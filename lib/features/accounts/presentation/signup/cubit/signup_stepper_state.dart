// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_stepper_cubit.dart';


class SignupStepperState extends Equatable {
 
  final int currentIndex;
  const SignupStepperState({

    required this.currentIndex,

  });

  @override
  List<Object> get props => [
        currentIndex
      ];
}
