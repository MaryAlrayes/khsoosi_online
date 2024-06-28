part of 'get_universities_bloc.dart';

sealed class GetUniversitiesEvent extends Equatable {
  const GetUniversitiesEvent();

  @override
  List<Object> get props => [];
}
class LoadUniversitiesEvent extends GetUniversitiesEvent{}
