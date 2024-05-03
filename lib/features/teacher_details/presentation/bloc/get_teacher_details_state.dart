part of 'get_teacher_details_bloc.dart';

sealed class GetTeacherDetailsState extends Equatable {
  const GetTeacherDetailsState();

  @override
  List<Object> get props => [];
}

final class GetTeacherDetailsInitial extends GetTeacherDetailsState {}

final class GetTeacherDetailsLoading extends GetTeacherDetailsState {}

class GetTeacherDetailsLoaded extends GetTeacherDetailsState {
  final TeacherDetailsEntity teacherDetailsEntity;
  GetTeacherDetailsLoaded({required this.teacherDetailsEntity});
  @override
  List<Object> get props => [teacherDetailsEntity];
}

class GetGetTeacherDetailsLoadedNoInternet extends GetTeacherDetailsState {}

class GetGetTeacherDetailsLoadedNetworkError extends GetTeacherDetailsState {
  final String message;
  GetGetTeacherDetailsLoadedNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
