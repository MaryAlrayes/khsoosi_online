// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/institute_details/domain/entities/institute_details_entity.dart';

import '../../domain/use_cases/get_institute_details_use_case.dart';

part 'get_institute_details_event.dart';
part 'get_institute_details_state.dart';

class GetInstituteDetailsBloc extends Bloc<GetInstituteDetailsEvent, GetInstituteDetailsState> {
 final GetInstituteDetailsUseCase getInstituteDetailsUseCase;
  GetInstituteDetailsBloc({
   required this.getInstituteDetailsUseCase,
  }) : super(GetInstituteDetailsInitial()) {
    on<LoadInstitutesDetailsEvent>((event, emit)async {
      emit(GetInstituteDetailsLoading());
          final res = await getInstituteDetailsUseCase(id: event.id);
          res.fold((f) {
            _mapFailureToState(emit, f);
          }, (data) {
            emit(GetInstituteDetailsLoaded(instituteDetailsEntity : data));
          });
      }
    );
  }

  _mapFailureToState(emit, Failure f) {
    switch (f) {
      case OfflineFailure():
        emit(GetInstituteDetailsNoInternet());

      case NetworkErrorFailure f:
        emit(GetInstituteDetailsNetworkError(message: f.message));
    }
  }
}
