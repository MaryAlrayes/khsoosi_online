// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_faq_bloc.dart';

sealed class GetFaqEvent extends Equatable {
  const GetFaqEvent();

  @override
  List<Object> get props => [];
}
class LoadFAQEvent extends GetFaqEvent {


}

class FilterQuestionBasedOnTypeEvent extends GetFaqEvent {
  final FAQUserType faqUserType;
  FilterQuestionBasedOnTypeEvent({
    required this.faqUserType,
  });
}
class FilterQuestionBasedOnKeywordEvent extends GetFaqEvent {
  final String keyword;
  FilterQuestionBasedOnKeywordEvent({
    required this.keyword,
  });
}
