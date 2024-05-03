part of 'get_cities_bloc.dart';

sealed class GetCitiesState extends Equatable {
  const GetCitiesState();

  @override
  List<Object> get props => [];
}


final class GetCitiesInitial extends GetCitiesState {}

final class GetCitiesLoading extends GetCitiesState {}

 class GetCitiesLoaded extends GetCitiesState {
  final List<CityEntity> cities;
  GetCitiesLoaded({required this.cities});
  @override
  List<Object> get props => [cities];
}

class GetCitiesNoInternet extends GetCitiesState{

}
class GetCitiesNetworkError extends GetCitiesState {
  final String message;
  GetCitiesNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
