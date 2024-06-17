// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_location_cubit.dart';

enum AddLocationStatus { init, loading, done, noInternet, networkError }

class AddLocationState extends Equatable {
  final CoordsEntity coordsEntity;
  final AddLocationStatus addLocationStatus;
  final String errorMessage;
  const AddLocationState({
    required this.coordsEntity,
    required this.addLocationStatus,
    required this.errorMessage,
  });
  factory AddLocationState.empty() {
    return AddLocationState(
      coordsEntity: CoordsEntity.empty(),
      addLocationStatus: AddLocationStatus.init,
      errorMessage: '',
    );
  }
  @override
  List<Object> get props => [
        coordsEntity,
        addLocationStatus,
        errorMessage,
      ];

  AddLocationState copyWith({
    CoordsEntity? coordsEntity,
    AddLocationStatus? addLocationStatus,
    String? errorMessage,
  }) {
    return AddLocationState(
      coordsEntity: coordsEntity ?? this.coordsEntity,
      addLocationStatus: addLocationStatus ?? this.addLocationStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
