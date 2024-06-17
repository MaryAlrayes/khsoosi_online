part of 'get_countries_bloc.dart';

sealed class GetCountriesState extends Equatable {
  const GetCountriesState();

  @override
  List<Object> get props => [];
}


final class GetCountriesInitial extends GetCountriesState {}

final class GetCountriesLoading extends GetCountriesState {}

 class GetCountriesLoaded extends GetCountriesState {
  final List<CountryEntity> countries;
  GetCountriesLoaded({required this.countries});
  @override
  List<Object> get props => [countries];
}

class GetCountriesNoInternet extends GetCountriesState{

}
class GetCountriesNetworkError extends GetCountriesState {
  final String message;
  GetCountriesNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
