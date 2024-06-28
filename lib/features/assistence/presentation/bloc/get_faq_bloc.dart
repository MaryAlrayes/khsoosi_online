import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/use_cases/fetch_faq_use_case.dart';

part 'get_faq_event.dart';
part 'get_faq_state.dart';

class GetFaqBloc extends Bloc<GetFaqEvent, GetFaqState> {
  final FetchFaqUseCase fetchFaqUseCase;
  GetFaqBloc({required this.fetchFaqUseCase}) : super(GetFaqState()) {
    on<LoadFAQEvent>((event, emit) async {
      emit(state.copyWith(status: GetFaqStatus.loading));
      final data = await fetchFaqUseCase();
      data.fold((failure) {
        _mapFailureToState(failure, emit);
      }, (data) {
        emit(state.copyWith(
          status: GetFaqStatus.success,
          filteredData: data,
          data: data,
        ));
      });
    });

    on<FilterQuestionBasedOnKeywordEvent>((event, emit) async {

      List<ArticleEntity> filteredData = state.data
          .where(
            (element) =>
                element.type == state.selectedType &&
                element.title.contains(event.keyword),
          )
          .toList();
      emit(state.copyWith(
        status: GetFaqStatus.success,
        keyword: event.keyword,
        filteredData: filteredData,
      ));
    });

    on<FilterQuestionBasedOnTypeEvent>((event, emit) async {
     List<ArticleEntity> filteredData = state.data
          .where(
            (element) => element.type == event.faqUserType,
          )
          .toList();
      emit(state.copyWith(
        status: GetFaqStatus.success,
        selectedType: event.faqUserType,
        filteredData: filteredData,
      ));
    });
  }

  _mapFailureToState(Failure f, Emitter emit) {
    switch (f) {
      case OfflineFailure():
        emit(state.copyWith(status: GetFaqStatus.offline));

      case NetworkErrorFailure f:
        emit(state.copyWith(
            status: GetFaqStatus.error, errorMessage: f.message));
    }
  }
}
