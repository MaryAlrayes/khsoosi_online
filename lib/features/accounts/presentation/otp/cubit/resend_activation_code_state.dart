part of 'resend_activation_code_cubit.dart';

sealed class ResendActivationCodeState extends Equatable {
  const ResendActivationCodeState();

  @override
  List<Object> get props => [];
}

final class ResendActivationCodeInitial extends ResendActivationCodeState {}

final class ResendActivationCodeLoading extends ResendActivationCodeState {}

class ResendActivationCodeDone extends ResendActivationCodeState {}

class ResendActivationCodesNoInternet extends ResendActivationCodeState {}

class ResendActivationCodeNetworkError extends ResendActivationCodeState {
  final String message;
  ResendActivationCodeNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
