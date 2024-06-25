import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/features/notification/domain/entities/notification_entity.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/use_cases/get_notification_use_case.dart';

part 'get_notification_state.dart';

class GetNotificationCubit extends Cubit<GetNotificationState> {
  final GetNotificationUseCase getNotificationUseCase;
  GetNotificationCubit({required this.getNotificationUseCase})
      : super(GetNotificationState.empty());
  void fetchNotification({required String userId}) async {
    emit(state.copyWith(status: GetNotificationStatus.loading));
    final res = await getNotificationUseCase.call(userId: userId);
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) {
      int newNotificationCounter = 0;
      data.forEach((e) {
        if (!e.isRead) newNotificationCounter++;
      });
      print('newNotificationCounter $newNotificationCounter');
      emit(state.copyWith(
          status: GetNotificationStatus.loaded, notifications: data,newNotificationsNumber: newNotificationCounter));
    });
  }
}

_mapFailureToState(emit, Failure f, GetNotificationState state) {
  switch (f) {
    case OfflineFailure():
      emit(state.copyWith(status: GetNotificationStatus.noInternet));

    case NetworkErrorFailure f:
      emit(state.copyWith(
          status: GetNotificationStatus.networkError, errorMessage: f.message));
  }
}
