import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/search/domain/entities/institute_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';

import '../../../domain/use cases/search_institutes_use_case.dart';

part 'get_institutes_event.dart';
part 'get_institutes_state.dart';

class GetInstitutesBloc extends Bloc<GetInstitutesEvent, GetInstitutesState> {
final SearchInstitutesUseCase searchInstitutesUseCase;
  GetInstitutesBloc({required this.searchInstitutesUseCase}) : super(GetInstitutesState()) {
     on<LoadInstitutesEvent>(
      (event, emit) async {
        if (event.refresh) {
          await _refreshData(emit, event.filter);
        } else if (state.hasReachedMax)
          return;
        else if (state.status == GetInstitutesStatus.loading) {
          await _loadingState(emit, event.filter);
        } else {
          await _loadingMore(emit, event.filter);
        }
      },
      transformer: droppable(),
    );
  }

  Future<void> _loadingMore(
      Emitter<GetInstitutesState> emit, SearchFilterEntity filter) async {
    emit(state.copyWith(status: GetInstitutesStatus.loadingMore));
    final data =
        await searchInstitutesUseCase(start: state.start, filter: filter);
    data.fold((failure) {
      _mapFailureToState(failure, emit);
    }, (data) {
      data.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: GetInstitutesStatus.success,
              data: List.of(state.data)..addAll(data),
              start: state.start + 4,
              hasReachedMax: false));
    });
  }

  Future<void> _loadingState(
      Emitter<GetInstitutesState> emit, SearchFilterEntity filter) async {
    final data =
        await searchInstitutesUseCase(start: state.start, filter: filter);
    await data.fold(
      (failure) {
        _mapFailureToState(failure, emit);
        return;
      },
      (data) {
        data.isEmpty
            ? emit(
                state.copyWith(
                  status: GetInstitutesStatus.success,
                  hasReachedMax: true,
                ),
              )
            : emit(
                state.copyWith(
                  status: GetInstitutesStatus.success,
                  data: data,
                  start: state.start + 4,
                  hasReachedMax: false,
                ),
              );
      },
    );
  }

  Future<void> _refreshData(
      Emitter<GetInstitutesState> emit, SearchFilterEntity filter) async {
    emit(
      state.copyWith(
        status: GetInstitutesStatus.loading,
        hasReachedMax: false,
        data: [],
        errorMessage: '',
        start: 0,
      ),
    );
    final data = await searchInstitutesUseCase(
      start: 0,
      filter: filter,
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
                  status: GetInstitutesStatus.success,
                  hasReachedMax: true,
                ),
              )
            : emit(
                state.copyWith(
                  status: GetInstitutesStatus.success,
                  data: data,
                  start: state.start + 4,
                  hasReachedMax: false,
                ),
              );
      },
    );
  }

  _mapFailureToState(Failure f, Emitter emit) {
    switch (f) {
      case OfflineFailure():
        emit(state.copyWith(status: GetInstitutesStatus.offline));

      case NetworkErrorFailure f:
        emit(state.copyWith(
            status: GetInstitutesStatus.error, errorMessage: f.message));
    }
  }
}
