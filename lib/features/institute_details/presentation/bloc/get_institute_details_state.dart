part of 'get_institute_details_bloc.dart';

sealed class GetInstituteDetailsState extends Equatable {
  const GetInstituteDetailsState();

  @override
  List<Object> get props => [];
}

final class GetInstituteDetailsInitial extends GetInstituteDetailsState {}

final class GetInstituteDetailsLoading extends GetInstituteDetailsState {}

 class GetInstituteDetailsLoaded extends GetInstituteDetailsState {
  final InstituteDetailsEntity instituteDetailsEntity;
  GetInstituteDetailsLoaded({required this.instituteDetailsEntity});
  @override
  List<Object> get props => [instituteDetailsEntity];
}

class GetInstituteDetailsNoInternet extends GetInstituteDetailsState{

}
class GetInstituteDetailsNetworkError extends GetInstituteDetailsState {
  final String message;
  GetInstituteDetailsNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
