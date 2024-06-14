// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/features/accounts/domain/entities/login_data_entity.dart';

class LoginDataModel extends LoginDataEntity {
final String ip;
  final String deviceInfo;
  final String serialNumber;
  LoginDataModel({
    required super.email,
    required super.password,
      required this.ip,
      required this.deviceInfo,
      required this.serialNumber,
  });


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'user_ip':ip,
      'user_agent_info':deviceInfo,
      'mobile_serial_number':serialNumber,
    
    };
  }


}
