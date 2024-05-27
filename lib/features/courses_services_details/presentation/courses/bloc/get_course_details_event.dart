// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_course_details_bloc.dart';

sealed class GetCourseDetailsEvent extends Equatable {
  const GetCourseDetailsEvent();

  @override
  List<Object> get props => [];
}
class FetchCourseDetailsEvent extends GetCourseDetailsEvent {
  final String id;
  FetchCourseDetailsEvent({
    required this.id,
  });
}
