import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import 'package:khosousi_online/features/statistics/domain/entities/requests_series_data.dart';

import '../../../domain/use_cases/activate_account_use_case.dart';

part 'activate_account_state.dart';

class ActivateAccountCubit extends Cubit<ActivateAccountState> {
  final ActivateAccountUseCase activateAccountUseCase;
  ActivateAccountCubit({
    required this.activateAccountUseCase,
  }) : super(ActivateAccountState.empty());

  void changeCode(String code) {
    emit(state.copyWith(
        activateCodeStatus: ActivateCodeStatus.init, code: code));
  }
  void submit({required String userId,})async{

    emit(state.copyWith(activateCodeStatus: ActivateCodeStatus.loading,errorMessage: ''));
    final res = await activateAccountUseCase(activationCode: state.code,userId: userId);
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {

      emit(state.copyWith(activateCodeStatus: ActivateCodeStatus.done,errorMessage:''));
    });
  }
}

_mapFailureToState(emit, Failure f, ActivateAccountState state) {
  switch (f) {
    case OfflineFailure():
      emit(state.copyWith(activateCodeStatus: ActivateCodeStatus.noInternet,errorMessage:''));

    case NetworkErrorFailure f:
      emit(state.copyWith(
          activateCodeStatus: ActivateCodeStatus.networkError, errorMessage: f.message));
  }
}
