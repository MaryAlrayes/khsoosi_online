part of 'get_courses_bloc.dart';


enum GetCoursesStatus { loading,loadingMore, success, offline, error }

class GetCoursesState extends Equatable {
  final GetCoursesStatus status;
  final List<CourseEntity> data;
  final int start;
  final bool hasReachedMax;
  final String errorMessage;

  const GetCoursesState(
      {this.status = GetCoursesStatus.loading,
      this.hasReachedMax = false,
      this.data = const [],
      this.start = 0,
      this.errorMessage = ""});

  @override
  List<Object> get props => [
        status,
        hasReachedMax,
        start,
        data,
        errorMessage,
      ];

  GetCoursesState copyWith({
    GetCoursesStatus? status,
    List<CourseEntity>? data,
    int? start,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return GetCoursesState(
      status: status ?? this.status,
      data: data ?? this.data,
      start: start ?? this.start,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
