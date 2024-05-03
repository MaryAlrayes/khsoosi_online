// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_cities_bloc.dart';

sealed class GetCitiesEvent extends Equatable {
  const GetCitiesEvent();

  @override
  List<Object> get props => [];
}

class LoadCitiesEvent extends GetCitiesEvent {
  final String country;
  LoadCitiesEvent({
    required this.country,
  });
}
class ResetCitiesEvent extends GetCitiesEvent{}
