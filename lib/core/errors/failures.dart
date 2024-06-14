// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NetworkErrorFailure extends Failure {
  final int? responseCode;
  final String message;
  NetworkErrorFailure({
    required this.message,
     this.responseCode
  });

  @override
  List<Object?> get props => [message,responseCode];
}
