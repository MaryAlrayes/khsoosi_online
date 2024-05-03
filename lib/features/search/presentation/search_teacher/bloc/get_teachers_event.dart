part of 'get_teachers_bloc.dart';

sealed class GetTeachersEvent extends Equatable {
  const GetTeachersEvent();

  @override
  List<Object> get props => [];
}
class LoadTeachersEvent extends GetTeachersEvent {
  final SearchFilterEntity filter;
  final bool refresh;
  LoadTeachersEvent( {
    required this.filter,
     this.refresh=false,
  });
}
