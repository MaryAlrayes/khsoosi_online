
import 'package:equatable/equatable.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
class SignupDataEntity extends Equatable {
  final UserType? userType;
  final String userName;
  final String name;
  final String email;
  final String confirmEmail;
  final String password;
  final String confirmPassword;
  final bool isCheckedTerms;
  const SignupDataEntity({
    required this.userType,
    required this.userName,
    required this.name,
    required this.email,
    required this.confirmEmail,
    required this.password,
    required this.confirmPassword,
    required this.isCheckedTerms,
  });

  factory SignupDataEntity.empty() {
    return SignupDataEntity(
        userType: null,
        confirmEmail: '',
        confirmPassword: '',
        email: '',
        password: '',
        name: '',
        userName: '',
        isCheckedTerms: false);
  }
  @override
  List<Object> get props => [
        userType.toString(),
        userName,
        name,
        email,
        confirmEmail,
        password,
        confirmPassword,
        isCheckedTerms
      ];
  SignupDataEntity copyWith(
      {UserType? userType,
      String? userName,
      String? name,
      String? email,
      String? confirmEmail,
      String? password,
      String? confirmPassword,
      bool? isCheckedTerms}) {
    return SignupDataEntity(
        userType: userType ?? this.userType,
        userName: userName ?? this.userName,
        name: name ?? this.name,
        email: email ?? this.email,
        confirmEmail: confirmEmail ?? this.confirmEmail,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isCheckedTerms: isCheckedTerms ?? this.isCheckedTerms);
  }


}
