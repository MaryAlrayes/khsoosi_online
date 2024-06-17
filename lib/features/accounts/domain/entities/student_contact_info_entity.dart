// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../../location/domain/entities/country_entity.dart';

class StudentContactInfoEntity extends Equatable {
  final String mobile;
  final CountryEntity mobileCountry;
  final String whatsapp;
  final CountryEntity whatsappCountry;
  final DateTime? bornDate;
  final Gender gender;
  final CountryEntity countryResidence;
  StudentContactInfoEntity({
    required this.mobile,
    required this.mobileCountry,
    required this.whatsapp,
    required this.whatsappCountry,
    required this.bornDate,
    required this.gender,
    required this.countryResidence,
  });

  factory StudentContactInfoEntity.empty() {
    return StudentContactInfoEntity(
        mobile: '',
        whatsapp: '',
        bornDate: null,
        countryResidence: CountryEntity.empty(),
        mobileCountry: CountryEntity.empty(),
        whatsappCountry: CountryEntity.empty(),
        gender: Gender.unspecified);
  }
  @override
  List<Object?> get props => [
        mobile,
        mobileCountry,
        whatsappCountry,
        whatsapp,
        bornDate,
        gender,
        countryResidence,
        mobileCountry,
        whatsappCountry
      ];

  StudentContactInfoEntity copyWith({
    String? mobile,
    CountryEntity? mobileCountry,
    String? whatsapp,
    CountryEntity? whatsappCountry,
    DateTime? bornDate,
    Gender? gender,
   CountryEntity? countryResidence,
  }) {
    return StudentContactInfoEntity(
      mobile: mobile ?? this.mobile,
      mobileCountry: mobileCountry ?? this.mobileCountry,
      whatsapp: whatsapp ?? this.whatsapp,
      whatsappCountry: whatsappCountry ?? this.whatsappCountry,
      bornDate: bornDate ?? this.bornDate,
      gender: gender ?? this.gender,
      countryResidence: countryResidence ?? this.countryResidence,

    );
  }
}
