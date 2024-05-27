
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/service_entity.dart';
import 'package:khosousi_online/features/search/domain/use%20cases/search_services_use_case.dart';

part 'get_services_event.dart';
part 'get_services_state.dart';

class GetServicesBloc extends Bloc<GetServicesEvent, GetServicesState> {
  final SearchServicesUseCase searchServicesUseCase;
  GetServicesBloc({
   required this.searchServicesUseCase,
  }
  ) : super(GetServicesState()) {
    on<LoadServicesEvent>(
      (event, emit) async {
        if (event.refresh) {
          await _refreshData(emit, event.filter);
        } else if (state.hasReachedMax)
          return;
        else if (state.status == GetServicesStatus.loading) {
          await _loadingState(emit, event.filter);
        } else {
          await _loadingMore(emit, event.filter);
        }
      },
      transformer: droppable(),
    );
  }

  Future<void> _loadingMore(
      Emitter<GetServicesState> emit, SearchFilterEntity filter) async {
    emit(state.copyWith(status: GetServicesStatus.loadingMore));
    final data =
        await searchServicesUseCase(start: state.start, filter: filter);
    data.fold((failure) {
      _mapFailureToState(failure, emit);
    }, (data) {
      data.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: GetServicesStatus.success,
              data: List.of(state.data)..addAll(data),
              start: state.start + 4,
              hasReachedMax: false));
    });
  }

  Future<void> _loadingState(
      Emitter<GetServicesState> emit, SearchFilterEntity filter) async {
    final data =
        await searchServicesUseCase(start: state.start, filter: filter);
    await data.fold(
      (failure) {
        _mapFailureToState(failure, emit);
        return;
      },
      (data) {
        data.isEmpty
            ? emit(
                state.copyWith(
                  status: GetServicesStatus.success,
                  hasReachedMax: true,
                ),
              )
            : emit(
                state.copyWith(
                  status: GetServicesStatus.success,
                  data: data,
                  start: state.start + 4,
                  hasReachedMax: false,
                ),
              );
      },
    );
  }

  Future<void> _refreshData(
      Emitter<GetServicesState> emit, SearchFilterEntity filter) async {
    emit(
      state.copyWith(
        status: GetServicesStatus.loading,
        hasReachedMax: false,
        data: [],
        errorMessage: '',
        start: 0,
      ),
    );
    final data = await searchServicesUseCase(
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
                  status: GetServicesStatus.success,
                  hasReachedMax: true,
                ),
              )
            : emit(
                state.copyWith(
                  status: GetServicesStatus.success,
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
        emit(state.copyWith(status: GetServicesStatus.offline));

      case NetworkErrorFailure f:
        emit(state.copyWith(
            status: GetServicesStatus.error, errorMessage: f.message));
    }
  }
}
