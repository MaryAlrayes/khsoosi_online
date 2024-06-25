import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import '../../domain/entities/article_entity.dart';
import '../../domain/use_cases/fetch_faq_use_case.dart';

part 'get_faq_event.dart';
part 'get_faq_state.dart';

class GetFaqBloc extends Bloc<GetFaqEvent, GetFaqState> {
  final FetchFaqUseCase fetchFaqUseCase;
  GetFaqBloc({required this.fetchFaqUseCase}) : super(GetFaqState()) {
    on<LoadFAQEvent>((event, emit)async {
       if (event.refresh) {
          await _refreshData(emit,);
        } else if (state.hasReachedMax)
          return;
        else if (state.status == GetFaqStatus.loading) {
          await _loadingState(emit, );
        } else {
          await _loadingMore(emit, );
        }
      },
      transformer: droppable(),
    );
  }

  Future<void> _loadingMore(
      Emitter<GetFaqState> emit, ) async {
    emit(state.copyWith(status: GetFaqStatus.loadingMore));
    final data =
        await fetchFaqUseCase(start: state.start, );
    data.fold((failure) {
      _mapFailureToState(failure, emit);
    }, (data) {
      data.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: GetFaqStatus.success,
              data: List.of(state.data)..addAll(data),
              start: state.start + 10,
              hasReachedMax: false));
    });
  }

  Future<void> _loadingState(
      Emitter<GetFaqState> emit, ) async {

    final data =
        await fetchFaqUseCase(start: state.start, );
    await data.fold(
      (failure) {
        _mapFailureToState(failure, emit);
        return;
      },
      (data) {
        data.isEmpty
            ? emit(
                state.copyWith(
                  status: GetFaqStatus.success,
                  hasReachedMax: true,
                ),
              )
            : emit(
                state.copyWith(
                  status: GetFaqStatus.success,
                  data: data,
                  start: state.start + 10,
                  hasReachedMax: false,
                ),
              );
      },
    );
  }

  Future<void> _refreshData(
      Emitter<GetFaqState> emit,) async {
    emit(
      state.copyWith(
        status: GetFaqStatus.loading,
        hasReachedMax: false,
        data: [],
        errorMessage: '',
        start: 0,
      ),
    );
    final data = await fetchFaqUseCase(
      start: 0,

    );

    await data.fold(
      (failure) {
        _mapFailureToState(failure, emit);
        return;
      },
      (data) {
        data.isEmpty
            ? emit(
                state.copyWith(
                  status: GetFaqStatus.success,
                  hasReachedMax: true,
                ),
              )
            : emit(
                state.copyWith(
                  status: GetFaqStatus.success,
                  data: data,
                  start: state.start +10,
                  hasReachedMax: false,
                ),
              );
      },
    );
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
