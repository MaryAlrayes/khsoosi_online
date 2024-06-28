part of 'get_universities_bloc.dart';

sealed class GetUniversitiesState extends Equatable {
  const GetUniversitiesState();

  @override
  List<Object> get props => [];
}

final class GetUniversitiesInitial extends GetUniversitiesState {}


final class GetUniversitiesLoading extends GetUniversitiesState {}

 class GetUniversitiesLoaded extends GetUniversitiesState {
  final List<UniversityEntity> universities;
  GetUniversitiesLoaded({required this.universities});
  @override
  List<Object> get props => [universities];
}

class GetUniversitiesNoInternet extends GetUniversitiesState{

}
class GetUniversitiesNetworkError extends GetUniversitiesState {
  final String message;
  GetUniversitiesNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
