// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginDataEntity extends Equatable {
  final String email;
  final String password;
  LoginDataEntity({
    required this.email,
    required this.password,
  });
  factory LoginDataEntity.empty() {
    return LoginDataEntity(
      email: '',
      password: '',
    );
  }
  @override
  List<Object?> get props => [email, password];

  LoginDataEntity copyWith({
    String? email,
    String? password,
  }) {
    return LoginDataEntity(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
