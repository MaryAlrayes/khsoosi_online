part of 'get_services_bloc.dart';

sealed class GetServicesEvent extends Equatable {
  const GetServicesEvent();

  @override
  List<Object> get props => [];
}
class LoadServicesEvent extends GetServicesEvent {
  final SearchFilterEntity filter;
  final bool refresh;
  LoadServicesEvent( {
    required this.filter,
     this.refresh=false,
  });
}
