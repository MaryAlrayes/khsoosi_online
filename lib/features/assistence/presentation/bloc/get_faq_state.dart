part of 'get_faq_bloc.dart';

enum GetFaqStatus { loading,loadingMore, success, offline, error }

 class GetFaqState extends Equatable {
  final GetFaqStatus status;
  final List<ArticleEntity> data;
  final int start;
  final bool hasReachedMax;
  final String errorMessage;

  const GetFaqState(
      {this.status = GetFaqStatus.loading,
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

  GetFaqState copyWith({
    GetFaqStatus? status,
    List<ArticleEntity>? data,
    int? start,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return GetFaqState(
      status: status ?? this.status,
      data: data ?? this.data,
      start: start ?? this.start,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
