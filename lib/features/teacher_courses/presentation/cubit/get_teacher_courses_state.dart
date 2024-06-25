part of 'get_teacher_courses_cubit.dart';

sealed class GetTeacherCoursesState extends Equatable {
  const GetTeacherCoursesState();

  @override
  List<Object> get props => [];
}

final class GetTeacherCoursesInitial extends GetTeacherCoursesState {}

final class GetTeacherCoursesLoading extends GetTeacherCoursesState {}

 class GetTeacherCoursesLoaded extends GetTeacherCoursesState {
  final List<TeacherCourseEntity> courses;
  GetTeacherCoursesLoaded({required this.courses});
  @override
  List<Object> get props => [courses];
}

class GetTeacherCoursesNoInternet extends GetTeacherCoursesState{

}
class GetTeacherCoursesNetworkError extends GetTeacherCoursesState {
  final String message;
  GetTeacherCoursesNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
