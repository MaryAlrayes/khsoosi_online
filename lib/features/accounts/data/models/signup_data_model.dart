import 'dart:io';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/accounts/domain/entities/signup_data_entity.dart';

class SignupDataModel extends SignupDataEntity {
  final String ip;
  final String deviceInfo;
  final String serialNumber;
  SignupDataModel(
      {required super.userType,
      required super.userName,
      required super.name,
      required super.email,
      required super.confirmEmail,
      required super.password,
      required super.confirmPassword,
      required super.isCheckedTerms,
      required this.ip,
      required this.deviceInfo,
      required this.serialNumber,
      });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Type': userType!.getValueForApi(),
      'Username': userName,
      'Name': name,
      'Email': email,
      'confirmEmail': confirmEmail,
      'Password': password,
      'ConfirmPassword': confirmPassword,
      'CheckboxTermsreaded': isCheckedTerms?'1':0,
      'user_ip':ip,
      'user_agent_info':deviceInfo,
      'mobile_serial_number':serialNumber,
    };
  }
}
