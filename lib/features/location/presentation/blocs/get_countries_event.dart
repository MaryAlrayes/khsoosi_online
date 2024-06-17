part of 'get_countries_bloc.dart';

sealed class GetCountriesEvent extends Equatable {
  const GetCountriesEvent();

  @override
  List<Object> get props => [];
}
class LoadCountriesEvent extends GetCountriesEvent{}
