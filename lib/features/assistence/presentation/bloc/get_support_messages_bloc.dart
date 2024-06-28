import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../domain/entities/support_message_entity.dart';
import '../../domain/use_cases/fetch_support_messages_use_case.dart';
import '../../domain/use_cases/submit_message_use_case.dart';

part 'get_support_messages_event.dart';
part 'get_support_messages_state.dart';

class GetSupportMessagesBloc
    extends Bloc<GetSupportMessagesEvent, GetSupportMessagesState> {
  final FetchSupportMessagesUseCase fetchSupportMessagesUseCase;
  final SubmitMessageUseCase submitMessageUseCase;
  GetSupportMessagesBloc(
      {required this.fetchSupportMessagesUseCase,
      required this.submitMessageUseCase})
      : super(GetSupportMessagesState()) {
        
    on<FetchSupportMessagesEvent>(
      (event, emit) async {
        if (event.refresh) {
          await _refreshData(emit, event);
        } else if (state.hasReachedMax)
          return;
        else if (state.status == GetSupportMessagesStatus.loading) {
          await _loadingState(emit, event);
        } else {
          await _loadingMore(emit, event);
        }
      },
      transformer: droppable(),
    );

    on<AddMessage>((event, emit) async {
      SupportMessageEntity messageEntity = SupportMessageEntity(
          id: 'id',
          message: event.message,
          date: DateTime.now(),
          supportMessageUser: SupportMessageUser.me,
          isRead: true,
          sendingNow: true);
      List<SupportMessageEntity> data = List.generate(
        state.data.length,
        (index) => state.data[index],
      );
      data.insert(0, messageEntity);
      emit(state.copyWith(data: data, submitStatus: SubmitStatus.loading));
      final res = await submitMessageUseCase.call(
        id: event.userId,
        message: event.message,
      );

      await res.fold((failure) {
        _mapFailureToSubmitMessagesState(failure, emit);
      }, (id) {
        data[0] = data[0].copyWith(id: id, sendingNow: false);
        emit(state.copyWith(data: data, submitStatus: SubmitStatus.success));
      });
    });
  }

  Future<void> _loadingMore(Emitter<GetSupportMessagesState> emit,
      FetchSupportMessagesEvent event) async {
    emit(state.copyWith(status: GetSupportMessagesStatus.loadingMore));
    final data =
        await fetchSupportMessagesUseCase(start: state.start, id: event.userId);
    data.fold((failure) {
      _mapFailureToGetMessagesState(failure, emit);
    }, (data) {
      data.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: GetSupportMessagesStatus.success,
              data: List.of(state.data)..addAll(data),
              start: state.start + 10,
              hasReachedMax: false));
    });
  }

  Future<void> _loadingState(Emitter<GetSupportMessagesState> emit,
      FetchSupportMessagesEvent event) async {
    final data =
        await fetchSupportMessagesUseCase(start: state.start, id: event.userId);
    await data.fold(
      (failure) {
        _mapFailureToGetMessagesState(failure, emit);
        return;
      },
      (data) {
        data.isEmpty
            ? emit(
                state.copyWith(
                  status: GetSupportMessagesStatus.success,
                  hasReachedMax: true,
                ),
              )
            : emit(
                state.copyWith(
                  status: GetSupportMessagesStatus.success,
                  data: data,
                  start: state.start + 10,
                  hasReachedMax: false,
                ),
              );
      },
    );
  }

  Future<void> _refreshData(Emitter<GetSupportMessagesState> emit,
      FetchSupportMessagesEvent event) async {
    emit(
      state.copyWith(
        status: GetSupportMessagesStatus.loading,
        hasReachedMax: false,
        data: [],
        errorMessage: '',
        start: 0,
      ),
    );
    final data =
        await fetchSupportMessagesUseCase(start: state.start, id: event.userId);

    await data.fold(
      (failure) {
        _mapFailureToGetMessagesState(failure, emit);
        return;
      },
      (data) {
        data.isEmpty
            ? emit(
                state.copyWith(
                  status: GetSupportMessagesStatus.success,
                  hasReachedMax: true,
                ),
              )
            : emit(
                state.copyWith(
                  status: GetSupportMessagesStatus.success,
                  data: data,
                  start: state.start + 10,
                  hasReachedMax: false,
                ),
              );
      },
    );
  }

  _mapFailureToGetMessagesState(Failure f, Emitter emit) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            status: GetSupportMessagesStatus.offline,
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            status: GetSupportMessagesStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }

  _mapFailureToSubmitMessagesState(Failure f, Emitter emit) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            submitStatus: SubmitStatus.offline,
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            submitStatus: SubmitStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }
}
