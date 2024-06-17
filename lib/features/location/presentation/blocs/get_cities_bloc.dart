// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import 'package:khosousi_online/features/location/domain/entities/city_entity.dart';
import 'package:khosousi_online/shared_features/domain/use_cases/get_cities_use_case.dart';

part 'get_cities_event.dart';
part 'get_cities_state.dart';

class GetCitiesBloc extends Bloc<GetCitiesEvent, GetCitiesState> {
  final GetCitiessUseCase getCitiessUseCase;
  GetCitiesBloc({
   required this.getCitiessUseCase,
  }
  ) : super(GetCitiesInitial()) {
    on<GetCitiesEvent>((event, emit) async{
       switch (event) {

        case LoadCitiesEvent():
          emit(GetCitiesLoading());
          final res = await getCitiessUseCase(country: event.country);
          res.fold((f) {
            _mapFailureToState(emit, f);
          }, (data) {
            emit(GetCitiesLoaded(cities: data));
          });
         case ResetCitiesEvent():
          emit(GetCitiesInitial());
      }
    });
  }

  _mapFailureToState(emit, Failure f) {
    switch (f) {
      case OfflineFailure():
        emit(GetCitiesNoInternet());

      case NetworkErrorFailure f:
        emit(GetCitiesNetworkError(message: f.message));
    }
  }
}
