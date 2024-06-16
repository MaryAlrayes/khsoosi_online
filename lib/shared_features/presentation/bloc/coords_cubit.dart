import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/shared_features/domain/entities/coords_entity.dart';
import 'package:khosousi_online/shared_features/domain/repositories/location_repo.dart';

part 'coords_state.dart';

class CoordsCubit extends Cubit<CoordsState> {
  final LocationRepo locationRepo;
  CoordsCubit({
    required this.locationRepo,
  }) : super(CoordsInitial());

  void fetchLocation() async {
    emit(CoordsLoading());
    final res = await locationRepo.getCoords();
    await res.fold((l) {
      emit(CoordsError());
    }, (coords) {
      emit(CoordsFetched(
        coords: coords,
      ));
    });
  }
}
