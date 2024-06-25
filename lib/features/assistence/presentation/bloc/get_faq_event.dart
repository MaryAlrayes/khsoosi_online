part of 'get_faq_bloc.dart';

sealed class GetFaqEvent extends Equatable {
  const GetFaqEvent();

  @override
  List<Object> get props => [];
}
class LoadFAQEvent extends GetFaqEvent {

  final bool refresh;
  LoadFAQEvent( {
     this.refresh=false,
  });
}
