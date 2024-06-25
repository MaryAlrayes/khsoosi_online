part of 'get_portofolio_details_bloc.dart';

sealed class GetPortofolioDetailsEvent extends Equatable {
  const GetPortofolioDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetDetailsEvent extends GetPortofolioDetailsEvent {
  final String id;
  GetDetailsEvent({
    required this.id,
  });
}
