import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/student_stat_entity.dart';
import '../../domain/use_cases/fetch_student_stat_use_case.dart';

part 'get_student_stat_state.dart';

class GetStudentStatCubit extends Cubit<GetStudentStatState> {
  final FetchStudentStatUseCase fetchStudentStatUseCase;
  GetStudentStatCubit({required this.fetchStudentStatUseCase}) : super(GetStudentStatInitial());

  void fetchStat({required String userId}) async {
    emit(GetStudentStatLoading());
    final res = await fetchStudentStatUseCase.call(userId: userId);
    res.fold((f) {
      _mapFailureToState(emit, f);
    }, (data) {
      emit(GetStudentStatLoaded(studentStatEntity: data));
    });
  }
}

_mapFailureToState(emit, Failure f) {
  switch (f) {
    case OfflineFailure():
      emit(GetTeacherStatNoInternet());

    case NetworkErrorFailure f:
      emit(GetStudentStatNetworkError(message: f.message));
  }
}

