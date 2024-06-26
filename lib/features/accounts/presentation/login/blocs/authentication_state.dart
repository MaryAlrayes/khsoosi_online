// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticatationLoading extends AuthenticationState {}

//no user --> show start up (login or search) screen
class UnauthenticatedState extends AuthenticationState {}

//user but missing data -> show continue registration info screen
class RegistrationInfoState extends AuthenticationState {
  final String type;
  final bool hasFinishedFirstInfo;
  RegistrationInfoState({
    required this.type,
    required this.hasFinishedFirstInfo,
  });
}


//user but has not confirm conditions  -> show conditions screen
class TermsAndConditionsState extends AuthenticationState {
  final String type;
  TermsAndConditionsState({
    required this.type,
  });
}

//user -> show homepage
class AuthenticatedState extends AuthenticationState {
}

