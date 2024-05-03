// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';
import 'package:khosousi_online/shared_features/domain/use_cases/get_countries_use_case.dart';

part 'get_countries_event.dart';
part 'get_countries_state.dart';

class GetCountriesBloc extends Bloc<GetCountriesEvent, GetCountriesState> {
  final GetCountriesUseCase getCountriesUseCase;
  GetCountriesBloc({
   required this.getCountriesUseCase,
  }
  ) : super(GetCountriesInitial()) {
    on<GetCountriesEvent>((event, emit) async{
    switch (event) {
        case LoadCountriesEvent():
          emit(GetCountriesLoading());
          final res = await getCountriesUseCase();
          res.fold((f) {
            _mapFailureToState(emit, f);
          }, (data) {
            emit(GetCountriesLoaded(countries: data));
          });
      }
    });
  }

  _mapFailureToState(emit, Failure f) {
    switch (f) {
      case OfflineFailure():
        emit(GetCountriesNoInternet());

      case NetworkErrorFailure f:
        emit(GetCountriesNetworkError(message: f.message));
    }
  }
}
