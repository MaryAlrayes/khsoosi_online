part of 'get_course_details_bloc.dart';

sealed class GetCourseDetailsState extends Equatable {
  const GetCourseDetailsState();

  @override
  List<Object> get props => [];
}

final class GetCourseDetailsInitial extends GetCourseDetailsState {}


final class GetCourseDetailsLoading extends GetCourseDetailsState {}

 class GetCourseDetailsLoaded extends GetCourseDetailsState {
  final CourseServiceDetailsEntity courseDetailsEntity;
  GetCourseDetailsLoaded({required this.courseDetailsEntity});
  @override
  List<Object> get props => [courseDetailsEntity];
}

class GetCourseDetailsNoInternet extends GetCourseDetailsState{

}
class GetCourseDetailsNetworkError extends GetCourseDetailsState {
  final String message;
  GetCourseDetailsNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
