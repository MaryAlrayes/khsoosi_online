// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

enum LoginStatus { init, loading, done, noInternet, networkError }

class LoginState extends Equatable {
  final LoginDataEntity loginDataEntity;
  final LoginStatus loginStatus;
  final String errorMessage;
  const LoginState({
    required this.loginDataEntity,
    required this.loginStatus,
    required this.errorMessage,
  });

  factory LoginState.empty() {
    return LoginState(
      loginDataEntity: LoginDataEntity.empty(),
      loginStatus: LoginStatus.init,
      errorMessage: '',
    );
  }
  @override
  List<Object> get props => [
        loginDataEntity,
        loginStatus,
        errorMessage,
      ];

  LoginState copyWith(
      {String? email,
      String? confirmEmail,
      String? password,
      LoginStatus? loginStatus,
      String? errorMessage}) {
    return LoginState(
        loginDataEntity: loginDataEntity.copyWith(
          email: email ?? this.loginDataEntity.email,
          password: password ?? this.loginDataEntity.password,
        ),
        loginStatus: loginStatus ?? this.loginStatus,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
