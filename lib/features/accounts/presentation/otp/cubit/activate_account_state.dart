// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'activate_account_cubit.dart';

enum ActivateCodeStatus { init, loading, done, noInternet, networkError }

class ActivateAccountState extends Equatable {
  final String code;
  final ActivateCodeStatus activateCodeStatus;
  final String errorMessage;
  const ActivateAccountState({
    required this.code,
    required this.activateCodeStatus,
    required this.errorMessage,
  });
  factory ActivateAccountState.empty() {
    return ActivateAccountState(
      code: '',
      activateCodeStatus: ActivateCodeStatus.init,
      errorMessage: '',
    );
  }

  @override
  List<Object> get props => [
        code,
        activateCodeStatus,
        errorMessage,
      ];

  ActivateAccountState copyWith({
    String? code,
    ActivateCodeStatus? activateCodeStatus,
    String? errorMessage,
  }) {
    return ActivateAccountState(
      code: code ?? this.code,
      activateCodeStatus: activateCodeStatus ?? this.activateCodeStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
