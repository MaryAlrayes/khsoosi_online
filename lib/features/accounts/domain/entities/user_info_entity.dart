// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable {
  final String userId;
  final String name;
  final String userName;
  final String email;
  final String imagePath;
  final String image;
  final String type;
  final String mobile;
  final String whatsapp;
  final double lat;
  final double lng;
  //has verified his/her account (otp)
  final bool isActive;
  //has entered his/her info
  final bool isEnabled;
  //has agreed on terms
  final bool isConditionAgreed;

  UserInfoEntity({
    required this.userId,
    required this.name,
    required this.userName,
    required this.email,
    required this.imagePath,
    required this.image,
    required this.type,
    required this.mobile,
    required this.whatsapp,
    required this.lat,
    required this.lng,
    required this.isActive,
    required this.isEnabled,
    required this.isConditionAgreed,
  });
  @override
  List<Object?> get props => [
    userId,
    name,
    userName,
    email,
    imagePath,
    image,
    type,
    mobile,
    whatsapp,
    lat,
    lng,
    isActive,
    isEnabled,
    isConditionAgreed,
      ];

  @override
  bool get stringify => true;
}
