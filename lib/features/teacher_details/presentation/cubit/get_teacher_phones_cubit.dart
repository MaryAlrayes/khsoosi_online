import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../domain/use cases/get_teacher_phones_use_case.dart';

part 'get_teacher_phones_state.dart';

class GetTeacherPhonesCubit extends Cubit<GetTeacherPhonesState> {
  final GetTeacherPhonesUseCase getTeacherPhonesUseCase;
  GetTeacherPhonesCubit({required this.getTeacherPhonesUseCase})
      : super(GetTeacherPhonesInitial());

  void getPhone(
      {required String teacherId,
      required TeacherPhones type,
      required String? requesterId,
      required String requesterFingerPrint,
      required bool isLoggedIn}) async {
    emit(GetTeacherPhonesLoading());
    final res = await getTeacherPhonesUseCase.call(
      teacherId: teacherId,
      type: type,
      requesterId: requesterId,
      requesterFingerPrint: requesterFingerPrint,
      isLoggedIn: isLoggedIn,
    );
    res.fold((f) {
      _mapFailureToState(emit, f);
    }, (data) {
      emit(GetTeacherPhonesLoaded(number: data,type: type));
    });
  }
}

_mapFailureToState(emit, Failure f) {
  switch (f) {
    case OfflineFailure():
      emit(GetTeacherPhonesNoInternet());

    case NetworkErrorFailure f:
      emit(GetTeacherPhonessNetworkError(message: f.message));
  }
}
