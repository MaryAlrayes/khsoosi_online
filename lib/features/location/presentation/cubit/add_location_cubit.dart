// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import 'package:khosousi_online/features/location/domain/entities/coords_entity.dart';

import '../../domain/use_cases/submit_location_use_case.dart';

part 'add_location_state.dart';

class AddLocationCubit extends Cubit<AddLocationState> {
  final SubmitLocationUseCase submitLocationUseCase;
  AddLocationCubit({
    required this.submitLocationUseCase,
  }) : super(AddLocationState.empty());

  void setLocation(CoordsEntity coordsEntity, String userId) async {
    emit(state.copyWith(
        addLocationStatus: AddLocationStatus.loading, errorMessage: ''));
    final res = await submitLocationUseCase.call(
      coords: coordsEntity,
      userId: userId,
    );
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(
        state.copyWith(
          addLocationStatus: AddLocationStatus.done,
          errorMessage: '',
        ),
      );
    });
  }
}

_mapFailureToState(emit, Failure f, AddLocationState state) {
  switch (f) {
    case OfflineFailure():
      emit(
        state.copyWith(
          addLocationStatus: AddLocationStatus.noInternet,
          errorMessage: '',
        ),
      );

    case NetworkErrorFailure f:
      emit(
        state.copyWith(
          addLocationStatus: AddLocationStatus.networkError,
          errorMessage: f.message,
        ),
      );
  }
}
