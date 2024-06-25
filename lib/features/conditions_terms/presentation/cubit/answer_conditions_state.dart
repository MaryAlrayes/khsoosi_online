// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'answer_conditions_cubit.dart';

enum AnswerConditionsStatus { init, loading, done, noInternet, networkError }

class AnswerConditionsState extends Equatable {
  final bool? answer;
  final AnswerConditionsStatus status;
  final String errorMessage;
  const AnswerConditionsState({
    required this.answer,
    required this.status,
    required this.errorMessage,
  });
  factory AnswerConditionsState.empty() {
    return AnswerConditionsState(
      answer: null,
      status: AnswerConditionsStatus.init,
      errorMessage: '',
    );
  }

  @override
  List<Object?> get props => [
        answer,
        status,
        errorMessage,
      ];

  AnswerConditionsState copyWith({
    bool? answer,
    AnswerConditionsStatus? status,
    String? errorMessage,
  }) {
    return AnswerConditionsState(
      answer: answer ?? this.answer,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool get stringify => true;
}
