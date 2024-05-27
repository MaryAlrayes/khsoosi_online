part of 'get_services_details_bloc.dart';

sealed class GetServicesDetailsEvent extends Equatable {
  const GetServicesDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchServiceDetailsEvent extends GetServicesDetailsEvent {
  final String id;
  FetchServiceDetailsEvent({
    required this.id,
  });
}
