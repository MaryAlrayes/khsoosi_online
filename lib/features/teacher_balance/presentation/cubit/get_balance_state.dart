part of 'get_balance_cubit.dart';

sealed class GetBalanceState extends Equatable {
  const GetBalanceState();

  @override
  List<Object> get props => [];
}

final class GetBalanceInitial extends GetBalanceState {}

final class GetBalanceLoading extends GetBalanceState {}

 class GetBalanceLoaded extends GetBalanceState {
  final TeacherBalanceEntity balanceEntity;
  GetBalanceLoaded({required this.balanceEntity});
  @override
  List<Object> get props => [balanceEntity];
}

class GetBalanceNoInternet extends GetBalanceState{

}
class GetBalanceNetworkError extends GetBalanceState {
  final String message;
  GetBalanceNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
