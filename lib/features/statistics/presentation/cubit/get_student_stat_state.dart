part of 'get_student_stat_cubit.dart';

sealed class GetStudentStatState extends Equatable {
  const GetStudentStatState();

  @override
  List<Object> get props => [];
}


final class GetStudentStatInitial extends GetStudentStatState {}

final class GetStudentStatLoading extends GetStudentStatState {}

 class GetStudentStatLoaded extends GetStudentStatState {
  final StudentStatEntity studentStatEntity;
  GetStudentStatLoaded({required this.studentStatEntity});
  @override
  List<Object> get props => [studentStatEntity];
}

class GetTeacherStatNoInternet extends GetStudentStatState{

}
class GetStudentStatNetworkError extends GetStudentStatState {
  final String message;
  GetStudentStatNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
