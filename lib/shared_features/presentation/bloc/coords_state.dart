part of 'coords_cubit.dart';

abstract class CoordsState extends Equatable {
  const CoordsState();

  @override
  List<Object> get props => [];
}

class CoordsInitial extends CoordsState {}
class CoordsLoading extends CoordsState {}
class CoordsFetched extends CoordsState {
  final CoordsEntity coords;
  const CoordsFetched({
    required this.coords,
  });

  @override
  List<Object> get props => [coords];
}

class CoordsError extends CoordsState {}
