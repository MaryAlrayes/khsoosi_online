// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import '../../domain/use_cases/change_password_use_case.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;
  ChangePasswordCubit({
    required this.changePasswordUseCase,
  }) : super(ChangePasswordState.empty());

  void changeOldPassword(String oldPassowrd) {
    emit(state.copyWith(
        oldPassowrd: oldPassowrd,
        changePasswordStatus: ChangePasswordStatus.init));
  }

  void changeNewPassword(String newPassword) {
    emit(state.copyWith(
        newPassword: newPassword,
        changePasswordStatus: ChangePasswordStatus.init));
  }

  void changeConfirmNewPassword(String confirmPassword) {
    emit(state.copyWith(
        confirmPassword: confirmPassword,
        changePasswordStatus: ChangePasswordStatus.init));
  }

  void submit(String userId) async {
    emit(state.copyWith(
        changePasswordStatus: ChangePasswordStatus.loading, errorMessage: ''));
    final res = await changePasswordUseCase.call(
      userId: userId,
      oldPassowrd: state.oldPassowrd,
      newPassword: state.newPassword,
      confirmPassword: state.confirmPassword,
    );
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(state.copyWith(changePasswordStatus: ChangePasswordStatus.done, errorMessage: ''));
    });
  }
}

_mapFailureToState(emit, Failure f, ChangePasswordState state) {
  switch (f) {
    case OfflineFailure():
      emit(
        state.copyWith(
          changePasswordStatus: ChangePasswordStatus.noInternet,
          errorMessage: '',
        ),
      );

    case NetworkErrorFailure f:
      emit(
        state.copyWith(
          changePasswordStatus: ChangePasswordStatus.networkError,
          errorMessage: f.message,
        ),
      );
  }
}
