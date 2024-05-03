// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

// "Id": "1",
//         "country_code": "AF",
//         "country_name_en": "Afghanistan",
//         "country_name_en_url": "Afghanistan",
//         "country_name_ar": "",
//         "calling_code": "93"
class CountryEntity extends Equatable {

  final String id;
  final String countryCode;
  final String countryNameEn;
  final String country_name_en_url;
  final String countryNameAr;
  final String callingCode;
  CountryEntity({
    required this.id,
    required this.countryCode,
    required this.countryNameEn,
    required this.country_name_en_url,
    required this.countryNameAr,
    required this.callingCode,
  });

  @override
  List<Object?> get props =>
  [
    id,
    countryCode,
    countryNameEn,
    country_name_en_url,
    countryNameAr,
    callingCode,
  ];


}
