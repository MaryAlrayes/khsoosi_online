part of 'refresh_account_cubit.dart';

sealed class RefreshAccountState extends Equatable {
  const RefreshAccountState();

  @override
  List<Object> get props => [];
}

final class RefreshAccountInitial extends RefreshAccountState {}

final class RefreshAccountLoading extends RefreshAccountState {}

final class RefreshAccountDone extends RefreshAccountState {}

final class RefreshAccountInternetError extends RefreshAccountState {}

final class RefreshAccountNetworkError extends RefreshAccountState {
  final String message;
  RefreshAccountNetworkError({required this.message});
}
