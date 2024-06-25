import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/statistics/domain/entities/teacher_stat_entity.dart';
import 'package:khosousi_online/features/statistics/domain/use_cases/fetch_teacher_stat_use_case.dart';

part 'get_teacher_stat_state.dart';

class GetTeacherStatCubit extends Cubit<GetTeacherStatState> {
  final FetchTeacherStatUseCase fetchTeacherStatUseCase;
  GetTeacherStatCubit({
    required this.fetchTeacherStatUseCase,
  }) : super(GetTeacherStatInitial());

  void fetchStat({required String userId}) async {
    emit(GetTeacherStatLoading());
    final res = await fetchTeacherStatUseCase.call(userId: userId);
    res.fold((f) {
      _mapFailureToState(emit, f);
    }, (data) {
      emit(GetTeacherStatLoaded(statEntity: data));
    });
  }
}

_mapFailureToState(emit, Failure f) {
  switch (f) {
    case OfflineFailure():
      emit(GetTeacherStatNoInternet());

    case NetworkErrorFailure f:
      emit(GetTeacherStatNetworkError(message: f.message));
  }
}
