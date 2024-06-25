part of 'get_services_details_bloc.dart';

sealed class GetServicesDetailsState extends Equatable {
  const GetServicesDetailsState();

  @override
  List<Object> get props => [];
}

final class GetServicesDetailsInitial extends GetServicesDetailsState {}


final class GetServicesDetailsLoading extends GetServicesDetailsState {}

 class GetServicesDetailsLoaded extends GetServicesDetailsState {
  final CourseServiceDetailsEntity courseDetailsEntity;
  GetServicesDetailsLoaded({required this.courseDetailsEntity});
  @override
  List<Object> get props => [courseDetailsEntity];
}

class GetServicesDetailsNoInternet extends GetServicesDetailsState{

}
class GetServicesDetailsNetworkError extends GetServicesDetailsState {
  final String message;
  GetServicesDetailsNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
