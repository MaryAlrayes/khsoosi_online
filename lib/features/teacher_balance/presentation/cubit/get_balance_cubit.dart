import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/teacher_balance_entity.dart';
import '../../domain/use_cases/fetch_balance_use_case.dart';

part 'get_balance_state.dart';

class GetBalanceCubit extends Cubit<GetBalanceState> {
  final FetchBalanceUseCase fetchBalanceUseCase;
  GetBalanceCubit({
    required this.fetchBalanceUseCase,
  }) : super(GetBalanceInitial());

  void fetchBalance({required String userId}) async {
    emit(GetBalanceLoading());
    final res = await fetchBalanceUseCase.call(userId: userId);
    res.fold((f) {
      _mapFailureToState(emit, f);
    }, (data) {
      emit(GetBalanceLoaded(balanceEntity: data));
    });
  }
}

_mapFailureToState(emit, Failure f) {
  switch (f) {
    case OfflineFailure():
      emit(GetBalanceNoInternet());

    case NetworkErrorFailure f:
      emit(GetBalanceNetworkError(message: f.message));
  }
}
