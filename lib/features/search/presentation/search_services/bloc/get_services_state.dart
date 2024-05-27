part of 'get_services_bloc.dart';

enum GetServicesStatus { loading,loadingMore, success, offline, error }

class GetServicesState extends Equatable {
  final GetServicesStatus status;
  final List<ServiceEntity> data;
  final int start;
  final bool hasReachedMax;
  final String errorMessage;

  const GetServicesState(
      {this.status = GetServicesStatus.loading,
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

  GetServicesState copyWith({
    GetServicesStatus? status,
    List<ServiceEntity>? data,
    int? start,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return GetServicesState(
      status: status ?? this.status,
      data: data ?? this.data,
      start: start ?? this.start,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
