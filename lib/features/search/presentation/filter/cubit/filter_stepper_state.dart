// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_stepper_cubit.dart';

class FilterStepperState extends Equatable {
  final int currentStep;
  const FilterStepperState({
    required this.currentStep,
  });

  @override
  List<Object> get props => [currentStep];

  FilterStepperState copyWith({
    int? currentStep,
  }) {
    return FilterStepperState(
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

