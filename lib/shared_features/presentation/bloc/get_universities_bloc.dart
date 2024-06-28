// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../domain/entities/university_entity.dart';
import '../../domain/use_cases/get_universities_use_case.dart';

part 'get_universities_event.dart';
part 'get_universities_state.dart';

class GetUniversitiesBloc extends Bloc<GetUniversitiesEvent, GetUniversitiesState> {
 final GetUniversitiesUseCase getUniversitiesUseCase;
  GetUniversitiesBloc({
   required this.getUniversitiesUseCase,
  }) : super(GetUniversitiesInitial()) {
   on<LoadUniversitiesEvent>((event, emit) async {
    emit(GetUniversitiesLoading());
          final res = await getUniversitiesUseCase();
          res.fold((f) {
            _mapFailureToState(emit, f);
          }, (data) {
            emit(GetUniversitiesLoaded(universities: data));
          });

    });
  }

  _mapFailureToState(emit, Failure f) {
    switch (f) {
      case OfflineFailure():
        emit(GetUniversitiesNoInternet());

      case NetworkErrorFailure f:
        emit(GetUniversitiesNetworkError(message: f.message));
    }
  }
}
