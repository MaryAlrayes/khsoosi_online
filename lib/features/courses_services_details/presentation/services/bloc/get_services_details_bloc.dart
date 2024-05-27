// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import 'package:khosousi_online/features/courses_services_details/domain/entities/course_service_details_entity.dart';
import 'package:khosousi_online/features/courses_services_details/domain/use%20cases/service_details_use_case.dart';

part 'get_services_details_event.dart';
part 'get_services_details_state.dart';

class GetServicesDetailsBloc extends Bloc<GetServicesDetailsEvent, GetServicesDetailsState> {
  final ServiceDetailsUseCase serviceDetailsUseCase;
  GetServicesDetailsBloc({
    required this.serviceDetailsUseCase,
  }) : super(GetServicesDetailsInitial()) {
    on<FetchServiceDetailsEvent>((event, emit)async {
      emit(GetServicesDetailsLoading());
          final res = await serviceDetailsUseCase(id: event.id);
          res.fold((f) {
            _mapFailureToState(emit, f);
          }, (data) {
            emit(GetServicesDetailsLoaded(courseDetailsEntity: data));
          });
      }
    );
  }

  _mapFailureToState(emit, Failure f) {
    switch (f) {
      case OfflineFailure():
        emit(GetServicesDetailsNoInternet());

      case NetworkErrorFailure f:
        emit(GetServicesDetailsNetworkError(message: f.message));
    }
  }
}
