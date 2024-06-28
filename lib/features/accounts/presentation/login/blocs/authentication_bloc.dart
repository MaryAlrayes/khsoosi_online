import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/utils/services/shared_preferences.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/domain/use_cases/fetch_user_data_use_case.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepo authRepository;
  final FetchUserDataUseCase fetchUserDataUseCase;

  AuthenticationBloc({
    required this.authRepository,
    required this.fetchUserDataUseCase,
  }) : super(AuthenticationInitial()) {
    on<AppStarted>((event, emit) async {
      await _appStarted(emit);
    });
    on<LogInUserEvent>((event, emit) async {
      await _logIn(emit, event);
    });
    on<LogOutUserEvent>((event, emit) async {
      await _logOut(emit);
    });
  }

  Future<void> _appStarted(Emitter<AuthenticationState> emit) async {
    await decideState(
      emit,
    );
  }

  Future<void> _logOut(Emitter<AuthenticationState> emit) async {
    emit(AuthenticatationLoading());
    //delete all data saved in shared preference
    await authRepository.deleteUserInfo();
    emit(UnauthenticatedState());
  }

  Future<void> _logIn(
      Emitter<AuthenticationState> emit, LogInUserEvent event) async {
    emit(AuthenticatationLoading());
    await decideState(emit);
  }

  decideState(Emitter<AuthenticationState> emit) async {
    //check if the user logged in by reading shared preference data from auth repo
    final hasUser = await authRepository.hasUserInfo();

    if (!hasUser) {
      // no user
      emit(UnauthenticatedState());
    } else if (hasUser) {
      // there is a user
      final userData = authRepository.getUserInfo();

      //get user info from server
      final res = await fetchUserDataUseCase(
        userId: userData!.userId,
      );

      await res.fold((failure) {
        //failure in getting user info so we rely on saved info
      }, (userData) async {
        //save new fetched data
        await authRepository.saveUserInfo(userData);
      });

      //get the data from repo
      final userInfo = authRepository.getUserInfo();

      //not enabled go to registeration info screen
      if (!userInfo!.isEnabled) {
         emit(
          RegistrationInfoState(
            type: userInfo.type,
            hasFinishedFirstInfo: userInfo.countryOfResidenseId!='0',
          ),
        );
      } else if (!userInfo.isConditionAgreed) {
        //the user has not agreed to terms
        emit(
          ConditionsState(
            type: userInfo.type,
          ),
        );
      } else {
        //otherwise the user is authenticated
        emit(AuthenticatedState());
      }
    }
  }
}
