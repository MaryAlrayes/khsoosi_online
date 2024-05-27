import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/refresh/domain/use_cases/refresh_account_use_case.dart';

part 'refresh_account_state.dart';

class RefreshAccountCubit extends Cubit<RefreshAccountState> {
  final RefreshAccountUseCase refreshAccountUseCase;
  RefreshAccountCubit({required this.refreshAccountUseCase})
      : super(RefreshAccountInitial());

  void refreshAccount() async {
    emit(RefreshAccountLoading());

    final res = await refreshAccountUseCase();

    await res.fold((f) {
      _mapFailureToState(emit, f);
    }, (data) {
      emit(RefreshAccountDone());
    });
  }
}

_mapFailureToState(emit, Failure f) {
  switch (f) {
    case OfflineFailure():
      emit(RefreshAccountInternetError());

    case NetworkErrorFailure f:
      emit(RefreshAccountNetworkError(message: f.message));
  }
}
