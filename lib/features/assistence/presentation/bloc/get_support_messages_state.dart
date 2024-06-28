// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_support_messages_bloc.dart';

enum GetSupportMessagesStatus { loading, loadingMore, success, offline, error }
enum SubmitStatus {init, loading,  success, offline, error }

class GetSupportMessagesState extends Equatable {
  final GetSupportMessagesStatus status;
  final SubmitStatus submitStatus;
  final List<SupportMessageEntity> data;
  final String errorMessage;
  final int start;
  final bool hasReachedMax;
  GetSupportMessagesState({
    this.status = GetSupportMessagesStatus.loading,
    this.submitStatus=SubmitStatus.init,
    this.data = const [],
    this.errorMessage = '',
    this.start = 0,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [status,submitStatus, data, errorMessage,start,hasReachedMax];

  GetSupportMessagesState copyWith({
    GetSupportMessagesStatus? status,
    SubmitStatus? submitStatus,
    List<SupportMessageEntity>? data,
    String? errorMessage,
    int? start,
    bool? hasReachedMax,
  }) {
    return GetSupportMessagesState(
      status: status ?? this.status,
      submitStatus: submitStatus ?? this.submitStatus,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      start: start ?? this.start,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
