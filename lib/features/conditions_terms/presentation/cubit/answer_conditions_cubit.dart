// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import '../../domain/use_cases/answer_conditions_use_case.dart';

part 'answer_conditions_state.dart';

class AnswerConditionsCubit extends Cubit<AnswerConditionsState> {
  final AnswerConditionsUseCase answerConditionsUseCase;
  AnswerConditionsCubit({
    required this.answerConditionsUseCase,
  }) : super(AnswerConditionsState.empty());

  void No() {
    emit(
      state.copyWith(
        status: AnswerConditionsStatus.init,
        answer: false,
        errorMessage: '',
      ),
    );
  }

  void reset() {
    AnswerConditionsState newState = AnswerConditionsState.empty();
    emit(newState);
  }

  void answer({required String userId, required bool answer}) async {
    emit(
      state.copyWith(
        status: AnswerConditionsStatus.loading,
        answer: answer,
        errorMessage: '',
      ),
    );
    final res = await answerConditionsUseCase.call(
      userId: userId,
      Conditions: answer,
    );
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(
        state.copyWith(
          status: AnswerConditionsStatus.done,
          errorMessage: '',
        ),
      );
    });
  }
}

_mapFailureToState(emit, Failure f, AnswerConditionsState state) {
  switch (f) {
    case OfflineFailure():
      emit(state.copyWith(
        status: AnswerConditionsStatus.noInternet,
      ));

    case NetworkErrorFailure f:
      emit(state.copyWith(
          status: AnswerConditionsStatus.networkError,
          errorMessage: f.message));
  }
}
