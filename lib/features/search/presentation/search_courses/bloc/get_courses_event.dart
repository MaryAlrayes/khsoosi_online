part of 'get_courses_bloc.dart';

sealed class GetCoursesEvent extends Equatable {
  const GetCoursesEvent();

  @override
  List<Object> get props => [];
}
class LoadCoursesEvent extends GetCoursesEvent {
  final SearchFilterEntity filter;
  final bool refresh;
  LoadCoursesEvent( {
    required this.filter,
     this.refresh=false,
  });
}
