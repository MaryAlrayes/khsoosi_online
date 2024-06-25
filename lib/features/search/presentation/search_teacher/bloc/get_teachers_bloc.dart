import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_entity.dart';
import 'package:khosousi_online/features/search/domain/use%20cases/search_teachers_use_case.dart';

import 'package:bloc_concurrency/bloc_concurrency.dart';
part 'get_teachers_event.dart';
part 'get_teachers_state.dart';

class GetTeachersBloc extends Bloc<GetTeachersEvent, GetTeachersState> {
  final SearchTeachersUseCase searchTeachersUseCase;

  GetTeachersBloc({required this.searchTeachersUseCase})
      : super(GetTeachersState()) {
    on<LoadTeachersEvent>(
      (event, emit) async {
       if (event.refresh) {
          await _refreshData(emit, event.filter);
        } else if (state.hasReachedMax)
          return;
        else if (state.status == GetTeachersStatus.loading) {
          await _loadingState(emit, event.filter);
        } else {
          await _loadingMore(emit, event.filter);
        }
      },
      transformer: droppable(),
    );
  }

  Future<void> _loadingMore(
      Emitter<GetTeachersState> emit, SearchFilterEntity filter) async {
    emit(state.copyWith(status: GetTeachersStatus.loadingMore));
    final data =
        await searchTeachersUseCase(start: state.start, filter: filter);
    data.fold((failure) {
      _mapFailureToState(failure, emit);
    }, (data) {
      data.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: GetTeachersStatus.success,
              data: List.of(state.data)..addAll(data),
              start: state.start + 4,
              hasReachedMax: false));
    });
  }

  Future<void> _loadingState(
      Emitter<GetTeachersState> emit, SearchFilterEntity filter) async {

    final data =
        await searchTeachersUseCase(start: state.start, filter: filter);
    await data.fold(
      (failure) {
        _mapFailureToState(failure, emit);
        return;
      },
      (data) {
        data.isEmpty
            ? emit(
                state.copyWith(
                  status: GetTeachersStatus.success,
                  hasReachedMax: true,
                ),
              )
            : emit(
                state.copyWith(
                  status: GetTeachersStatus.success,
                  data: data,
                  start: state.start + 4,
                  hasReachedMax: false,
                ),
              );
      },
    );
  }

  Future<void> _refreshData(
      Emitter<GetTeachersState> emit, SearchFilterEntity filter) async {
    emit(
      state.copyWith(
        status: GetTeachersStatus.loading,
        hasReachedMax: false,
        data: [],
        errorMessage: '',
        start: 0,
      ),
    );
    final data = await searchTeachersUseCase(
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
                  status: GetTeachersStatus.success,
                  hasReachedMax: true,
                ),
              )
            : emit(
                state.copyWith(
                  status: GetTeachersStatus.success,
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
        emit(state.copyWith(status: GetTeachersStatus.offline));

      case NetworkErrorFailure f:
        emit(state.copyWith(
            status: GetTeachersStatus.error, errorMessage: f.message));
    }
  }
}
