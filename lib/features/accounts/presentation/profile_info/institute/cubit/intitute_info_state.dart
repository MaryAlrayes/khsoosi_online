part of 'intitute_info_cubit.dart';

enum IntituteInfoStatus { init, loading, done, noInternet, networkError }

class IntituteInfoState extends Equatable {
  final InstituteContactEnitity instituteContactEnitity;
  final IntituteInfoStatus intituteInfoStatus;
  final String errorMessage;
  IntituteInfoState({
    required this.instituteContactEnitity,
    required this.intituteInfoStatus,
    required this.errorMessage,
  });

  factory IntituteInfoState.empty() {
    return IntituteInfoState(
        errorMessage: '',
        instituteContactEnitity: InstituteContactEnitity.empty(),
        intituteInfoStatus: IntituteInfoStatus.init);
  }
  @override
  List<Object> get props => [
        instituteContactEnitity,
        intituteInfoStatus,
        errorMessage,
      ];

  IntituteInfoState copyWith({
    InstituteContactEnitity? info,
    IntituteInfoStatus? intituteInfoStatus,
    String? errorMessage,
  }) {
    return IntituteInfoState(
        instituteContactEnitity: info ?? this.instituteContactEnitity,
        intituteInfoStatus: intituteInfoStatus ?? this.intituteInfoStatus,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  bool get stringify => true;
}
