part of 'get_teachers_bloc.dart';

enum GetTeachersStatus { loading,loadingMore, success, offline, error }

class GetTeachersState extends Equatable {
  final GetTeachersStatus status;
  final List<TeacherEntity> data;
  final int start;
  final bool hasReachedMax;
  final String errorMessage;

  const GetTeachersState(
      {this.status = GetTeachersStatus.loading,
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

  GetTeachersState copyWith({
    GetTeachersStatus? status,
    List<TeacherEntity>? data,
    int? start,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return GetTeachersState(
      status: status ?? this.status,
      data: data ?? this.data,
      start: start ?? this.start,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
