part of 'get_institutes_bloc.dart';
enum GetInstitutesStatus {loading,loadingMore, success, offline, error }

 class GetInstitutesState extends Equatable {
  final GetInstitutesStatus status;
  final List<InstituteEntity> data;
  final int start;
  final bool hasReachedMax;
  final String errorMessage;

  const GetInstitutesState(
      {this.status = GetInstitutesStatus.loading,
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

  GetInstitutesState copyWith({
    GetInstitutesStatus? status,
    List<InstituteEntity>? data,
    int? start,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return GetInstitutesState(
      status: status ?? this.status,
      data: data ?? this.data,
      start: start ?? this.start,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
