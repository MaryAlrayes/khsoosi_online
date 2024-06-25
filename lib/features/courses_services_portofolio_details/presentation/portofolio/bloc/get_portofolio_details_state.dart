part of 'get_portofolio_details_bloc.dart';

sealed class GetPortofolioDetailsState extends Equatable {
  const GetPortofolioDetailsState();

  @override
  List<Object> get props => [];
}

final class GetPortofolioDetailsInitial extends GetPortofolioDetailsState {}


final class GetPortofolioDetailsLoading extends GetPortofolioDetailsState {}

 class GetPortofolioDetailsLoaded extends GetPortofolioDetailsState {
  final PortofolioDetailsEntity portofolioDetailsEntity;
  GetPortofolioDetailsLoaded({required this.portofolioDetailsEntity});
  @override
  List<Object> get props => [portofolioDetailsEntity];
}

class GetPortofolioDetailsNoInternet extends GetPortofolioDetailsState{

}
class GetPortofolioDetailsNetworkError extends GetPortofolioDetailsState {
  final String message;
  GetPortofolioDetailsNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
