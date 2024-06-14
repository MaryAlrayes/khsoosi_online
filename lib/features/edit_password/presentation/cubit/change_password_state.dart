// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_password_cubit.dart';

enum ChangePasswordStatus { init, loading, done, noInternet, networkError }

class ChangePasswordState extends Equatable {
  final String oldPassowrd;
  final String newPassword;
  final String confirmPassword;
  final ChangePasswordStatus changePasswordStatus;
  final String errorMessage;
  const ChangePasswordState({
    required this.oldPassowrd,
    required this.newPassword,
    required this.confirmPassword,
    required this.changePasswordStatus,
    required this.errorMessage,
  });
  factory ChangePasswordState.empty() {
    return ChangePasswordState(
      oldPassowrd: '',
      newPassword: '',
      confirmPassword: '',
      changePasswordStatus: ChangePasswordStatus.init,
      errorMessage: '',
    );
  }

  @override
  List<Object> get props => [
        oldPassowrd,
        newPassword,
        confirmPassword,
        changePasswordStatus,
        errorMessage,
      ];

  ChangePasswordState copyWith({
    String? oldPassowrd,
    String? newPassword,
    String? confirmPassword,
    ChangePasswordStatus? changePasswordStatus,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      oldPassowrd: oldPassowrd ?? this.oldPassowrd,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
