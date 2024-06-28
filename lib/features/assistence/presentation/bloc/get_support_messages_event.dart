// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_support_messages_bloc.dart';

sealed class GetSupportMessagesEvent extends Equatable {
  const GetSupportMessagesEvent();

  @override
  List<Object> get props => [];
}
class FetchSupportMessagesEvent extends GetSupportMessagesEvent {
  final String userId;
  final bool refresh;
  FetchSupportMessagesEvent( {
required this.userId,
     this.refresh=false,
  });

}

class AddMessage extends GetSupportMessagesEvent {
   final String userId;
  final String message;
  AddMessage({
     required this.userId,
    required this.message,
  });
}
