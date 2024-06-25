part of 'get_teacher_services_cubit.dart';

sealed class GetTeacherServicesState extends Equatable {
  const GetTeacherServicesState();

  @override
  List<Object> get props => [];
}


final class GetTeacherServicesInitial extends GetTeacherServicesState {}

final class GetTeacherServicesLoading extends GetTeacherServicesState {}

 class GetTeacherServicesLoaded extends GetTeacherServicesState {
  final List<TeacherServiceEntity> services;
  GetTeacherServicesLoaded({required this.services});
  @override
  List<Object> get props => [services];
}

class GetTeacherServicesNoInternet extends GetTeacherServicesState{

}
class GetTeacherServicesNetworkError extends GetTeacherServicesState {
  final String message;
  GetTeacherServicesNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
