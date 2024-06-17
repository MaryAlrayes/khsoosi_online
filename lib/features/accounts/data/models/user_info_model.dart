// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/accounts/domain/entities/user_info_entity.dart';

class UserInfoModel extends UserInfoEntity {
  UserInfoModel({
    required super.userId,
    required super.name,
    required super.userName,
    required super.email,
    required super.imagePath,
    required super.image,
    required super.type,
    required super.isActive,
    required super.isEnabled,
    required super.isConditionAgreed,
    required super.mobile,
    required super.whatsapp,
    required super.lat,
    required super.lng,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Id': userId,
      'Name': name,
      'User_name': userName,
      'Email': email,
      'Image_path': imagePath,
      'Type': type,
      'Mobile':mobile,
      'Whatsapp':whatsapp,
      'latitude':lat.toString(),
      'longitude':lng.toString(),
      'Is_active': isActive ? '1' : '0',
      'Is_enabled': isEnabled ? '1' : '0',
      'Is_conditions_agreed': isConditionAgreed ? '1' : '0',
    };
  }

  factory UserInfoModel.fromJson(Map<String, dynamic> map) {
    return UserInfoModel(
      userId: map['Id'] ?? map['id'] ?? '',
      name: map['Name'] ?? map['name'] ?? '',
      userName: map['User_name'] ?? '',
      email: map['Email'] ?? map['email'] ?? '',
      mobile:map['Mobile']==null|| map['Mobile']==false ? '':map['Mobile'],
      whatsapp: map['Whatsapp']==null || map['Whatsapp']==false ? '':map['Whatsapp'],
      imagePath: map['Image_path'] ?? '',
      lat: map['latitude']==null ? 0:double.parse(map['latitude']as String),
      lng: map['longitude']==null ? 0:double.parse(map['longitude']as String),
      image: map['Image_path'] == null || (map['Image_path'] as String).isEmpty
          ? map['Jender'] == '0'
              ? EndPointsManager.maleUserDefaultImageBaseUrl
              : EndPointsManager.femaleUserDefaultImageBaseUrl
          : EndPointsManager.userImageBaseUrl + map['Image_path'],
      type: map['Type'] ?? map['type'] ?? '',
      isActive: map['Is_active'] == '1',
      isEnabled: map['Is_enabled'] == '1',
      isConditionAgreed: map['Is_conditions_agreed'] == '1',
    );
  }

  UserInfoModel copyWith({
    String? userId,
    String? name,
    String? userName,
    String? email,
    String? imagePath,
    String? image,
    String? type,
    String? mobile,
    String? whatsapp,
    double? lat,
    double? lng,
    bool? isActive,
    bool? isEnabled,
    bool? isConditionAgreed,
  }) {
    return UserInfoModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      image: image ?? this.image,
      type: type ?? this.type,
      mobile: mobile ?? this.mobile,
      whatsapp: whatsapp ?? this.whatsapp,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isActive: isActive ?? this.isActive,
      isEnabled: isEnabled ?? this.isEnabled,
      isConditionAgreed: isConditionAgreed ?? this.isConditionAgreed,
    );
  }


}
