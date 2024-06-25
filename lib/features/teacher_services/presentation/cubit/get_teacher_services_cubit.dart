import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_services/domain/entities/teacher_service_entity.dart';
import 'package:khosousi_online/features/teacher_services/domain/use_cases/fetch_teacher_services_use_case.dart';

part 'get_teacher_services_state.dart';

class GetTeacherServicesCubit extends Cubit<GetTeacherServicesState> {
  final FetchTeacherServicesUseCase fetchTeacherServicesUseCase;
  GetTeacherServicesCubit({
    required this.fetchTeacherServicesUseCase,
  }) : super(GetTeacherServicesInitial());

  void fetchServices({required String userId}) async {
    emit(GetTeacherServicesLoading());
    final res = await fetchTeacherServicesUseCase.call(userId: userId);
    res.fold((f) {
      _mapFailureToState(emit, f);
    }, (data) {
      emit(GetTeacherServicesLoaded(services: data));
    });
  }
}

_mapFailureToState(emit, Failure f) {
  switch (f) {
    case OfflineFailure():
      emit(GetTeacherServicesNoInternet());

    case NetworkErrorFailure f:
      emit(GetTeacherServicesNetworkError(message: f.message));
  }
}
