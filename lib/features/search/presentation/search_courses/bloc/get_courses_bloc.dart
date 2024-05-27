import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/search/domain/entities/course_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';

import '../../../domain/use cases/search_courses_use_case.dart';

part 'get_courses_event.dart';
part 'get_courses_state.dart';

class GetCoursesBloc extends Bloc<GetCoursesEvent, GetCoursesState> {
  final SearchCoursesUseCase searchCoursesUseCase;
  GetCoursesBloc({
    required this.searchCoursesUseCase,
  }) : super(GetCoursesState()) {
    on<LoadCoursesEvent>(
      (event, emit) async {
        if (event.refresh) {
          await _refreshData(emit, event.filter);
        } else if (state.hasReachedMax)
          return;
        else if (state.status == GetCoursesStatus.loading) {
          await _loadingState(emit, event.filter);
        } else {
          await _loadingMore(emit, event.filter);
        }
      },
      transformer: droppable(),
    );
  }

  Future<void> _loadingMore(
      Emitter<GetCoursesState> emit, SearchFilterEntity filter) async {
    emit(state.copyWith(status: GetCoursesStatus.loadingMore));
    final data =
        await searchCoursesUseCase(start: state.start, filter: filter);
    data.fold((failure) {
      _mapFailureToState(failure, emit);
    }, (data) {
      data.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: GetCoursesStatus.success,
              data: List.of(state.data)..addAll(data),
              start: state.start + 4,
              hasReachedMax: false));
    });
  }

  Future<void> _loadingState(
      Emitter<GetCoursesState> emit, SearchFilterEntity filter) async {
    final data =
        await searchCoursesUseCase(start: state.start, filter: filter);
    await data.fold(
      (failure) {
        _mapFailureToState(failure, emit);
        return;
      },
      (data) {
        data.isEmpty
            ? emit(
                state.copyWith(
                  status: GetCoursesStatus.success,
                  hasReachedMax: true,
                ),
              )
            : emit(
                state.copyWith(
                  status: GetCoursesStatus.success,
                  data: data,
                  start: state.start + 4,
                  hasReachedMax: false,
                ),
              );
      },
    );
  }

  Future<void> _refreshData(
      Emitter<GetCoursesState> emit, SearchFilterEntity filter) async {
    emit(
      state.copyWith(
        status: GetCoursesStatus.loading,
        hasReachedMax: false,
        data: [],
        errorMessage: '',
        start: 0,
      ),
    );
    final data = await searchCoursesUseCase(
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
                  status: GetCoursesStatus.success,
                  hasReachedMax: true,
                ),
              )
            : emit(
                state.copyWith(
                  status: GetCoursesStatus.success,
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
        emit(state.copyWith(status: GetCoursesStatus.offline));

      case NetworkErrorFailure f:
        emit(state.copyWith(
            status: GetCoursesStatus.error, errorMessage: f.message));
    }
  }
}
