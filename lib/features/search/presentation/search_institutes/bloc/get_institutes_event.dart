part of 'get_institutes_bloc.dart';

sealed class GetInstitutesEvent extends Equatable {
  const GetInstitutesEvent();

  @override
  List<Object> get props => [];
}
class LoadInstitutesEvent extends GetInstitutesEvent {
  final SearchFilterEntity filter;
  final bool refresh;
  LoadInstitutesEvent( {
    required this.filter,
     this.refresh=false,
  });
}
