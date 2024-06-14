// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/features/accounts/domain/entities/login_data_entity.dart';

import 'package:khosousi_online/features/accounts/domain/entities/signup_data_entity.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/login_use_case.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../domain/entities/signup_data_entity.dart';
import '../../../domain/entities/signup_data_entity.dart';
import '../../../domain/entities/signup_data_entity.dart';
import '../../../domain/use_cases/signup_use_case.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;
  SignupCubit({
    required this.signupUseCase,
  }) : super(SignupState.empty());

  void setUserType(UserType userType) {
    emit(state.copyWith(userType: userType,signupStatus: SignupStatus.init));
  }

  void setName(String name) {
    emit(state.copyWith(name: name,signupStatus: SignupStatus.init));
  }

  void setUserName(String userName) {
    emit(state.copyWith(userName: userName,signupStatus: SignupStatus.init));
  }

  void setEmail(String email) {
    emit(state.copyWith(email: email,signupStatus: SignupStatus.init));
  }

  void setConfirmEmail(String confirmEmail) {
    emit(state.copyWith(confirmEmail: confirmEmail,signupStatus: SignupStatus.init));
  }

  void setPassword(String password) {
    emit(state.copyWith(password: password,signupStatus: SignupStatus.init));
  }

  void setConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword,signupStatus: SignupStatus.init));
  }

  void setCheckTerms(bool isChecked) {
    emit(state.copyWith(isCheckedTerms: isChecked,signupStatus: SignupStatus.init));
  }

  void submit() async {
    emit(state.copyWith(signupStatus: SignupStatus.loading,errorMessage:''));
    final res = await signupUseCase(signupDataEntity: state.signupDataEntity);
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {

      emit(state.copyWith(signupStatus: SignupStatus.done,errorMessage:''));
    });
  }
}

_mapFailureToState(emit, Failure f, SignupState state) {
  switch (f) {
    case OfflineFailure():
      emit(state.copyWith(signupStatus: SignupStatus.noInternet,errorMessage:''));

    case NetworkErrorFailure f:
      emit(state.copyWith(
          signupStatus: SignupStatus.networkError, errorMessage: f.message));
  }
}
