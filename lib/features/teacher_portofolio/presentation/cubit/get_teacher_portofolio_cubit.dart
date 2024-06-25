// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import '../../domain/entities/teacher_portofolio_entity.dart';
import '../../domain/use_cases/fetch_teacher_portofolio_use_case.dart';

part 'get_teacher_portofolio_state.dart';

class GetTeacherPortofolioCubit extends Cubit<GetTeacherPortofolioState> {
  final FetchTeacherPortofolioUseCase fetchTeacherPortofolioUseCase;
  GetTeacherPortofolioCubit({required this.fetchTeacherPortofolioUseCase})
 : super(GetTeacherPortofolioInitial());

  void fetchPortofolio({required String userId}) async {
    emit(GetTeacherPortofolioLoading());
    final res = await fetchTeacherPortofolioUseCase.call(userId: userId);
    res.fold((f) {
      _mapFailureToState(emit, f);
    }, (data) {
      emit(GetTeacherPortofolioLoaded(portfolio : data));
    });
  }
}

_mapFailureToState(emit, Failure f) {
  switch (f) {
    case OfflineFailure():
      emit(GetTeacherPortofolioNoInternet());

    case NetworkErrorFailure f:
      emit(GetTeacherPortofolioNetworkError(message: f.message));
  }
}
