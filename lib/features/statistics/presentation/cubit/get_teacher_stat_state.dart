part of 'get_teacher_stat_cubit.dart';

sealed class GetTeacherStatState extends Equatable {
  const GetTeacherStatState();

  @override
  List<Object> get props => [];
}

final class GetTeacherStatInitial extends GetTeacherStatState {}

final class GetTeacherStatLoading extends GetTeacherStatState {}

 class GetTeacherStatLoaded extends GetTeacherStatState {
  final TeacherStatEntity statEntity;
  GetTeacherStatLoaded({required this.statEntity});
  @override
  List<Object> get props => [statEntity];
}

class GetTeacherStatNoInternet extends GetTeacherStatState{

}
class GetTeacherStatNetworkError extends GetTeacherStatState {
  final String message;
  GetTeacherStatNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
