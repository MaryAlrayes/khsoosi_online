// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import '../../../domain/use_cases/resend_activation_code_use_case.dart';

part 'resend_activation_code_state.dart';

class ResendActivationCodeCubit extends Cubit<ResendActivationCodeState> {
  final ResendActivationCodeUseCase resendActivationCodeUseCase;
  ResendActivationCodeCubit({
   required this.resendActivationCodeUseCase,
  }  ) : super(ResendActivationCodeInitial());

  void resend(String userId)async{
    emit(ResendActivationCodeLoading());
    final res = await resendActivationCodeUseCase(userId: userId);
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {

      emit(ResendActivationCodeDone());
    });
  }
}

_mapFailureToState(emit, Failure f, ResendActivationCodeState state) {
  switch (f) {
    case OfflineFailure():
      emit(ResendActivationCodesNoInternet());

    case NetworkErrorFailure f:
      emit(ResendActivationCodeNetworkError(message: f.message));
  }
}
