// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_faq_bloc.dart';

enum GetFaqStatus { loading, success, offline, error }

class GetFaqState extends Equatable {
  final GetFaqStatus status;
  final List<ArticleEntity> data;
  final List<ArticleEntity> filteredData;
  final FAQUserType selectedType;
  final String keyword;
  final String errorMessage;

  const GetFaqState({
    this.status = GetFaqStatus.loading,
    this.data = const [],
    this.filteredData = const [],
    this.selectedType=FAQUserType.both,
    this.keyword='',
    this.errorMessage = ""
  });

  @override
  List<Object> get props => [
        status,
        filteredData,
        data,
        errorMessage,
        selectedType,
        keyword
      ];



  GetFaqState copyWith({
    GetFaqStatus? status,
    List<ArticleEntity>? data,
    List<ArticleEntity>? filteredData,
    FAQUserType? selectedType,
    String? keyword,
    String? errorMessage,
  }) {
    return GetFaqState(
      status: status ?? this.status,
      data: data ?? this.data,
      filteredData: filteredData ?? this.filteredData,
      selectedType: selectedType ?? this.selectedType,
      keyword: keyword ?? this.keyword,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
