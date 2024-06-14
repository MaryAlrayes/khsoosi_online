import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/entities/login_data_entity.dart';

import '../../../domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  LoginCubit({required this.loginUseCase}) : super(LoginState.empty());


  void setEmail(String email) {
    emit(state.copyWith(email: email,loginStatus: LoginStatus.init));
  }

  void setPassword(String password) {
    emit(state.copyWith(password: password,loginStatus: LoginStatus.init));
  }
void submit() async {
  emit(state.copyWith(loginStatus: LoginStatus.loading));
    final res = await loginUseCase(loginDataEntity: state.loginDataEntity);
    res.fold((f) {
      _mapFailureToState(emit, f,state);
    }, (data) {
       emit(state.copyWith(loginStatus: LoginStatus.done));

    });
  }
}

_mapFailureToState(emit, Failure f,LoginState state) {
  switch (f) {
    case OfflineFailure():
       emit(state.copyWith(loginStatus: LoginStatus.noInternet));

    case NetworkErrorFailure f:
      emit(state.copyWith(loginStatus: LoginStatus.networkError,errorMessage: f.message));

  }
}
