// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/shared_features/domain/entities/city_entity.dart';

import '../../../../shared_features/domain/entities/country_entity.dart';

class TeacherContactInfoEntity extends Equatable {
  final String mobile;
  final CountryEntity mobileCountry;
  final String whatsapp;
  final CountryEntity whatsappCountry;
  final DateTime? bornDate;
  final Gender gender;
  final CountryEntity countryResidence;
  final CityEntity? cityResidence;
  final CountryEntity nationality;
  final String? facebook;
  final String? instagram;
  final String? tiktok;
  final String? youtube;
  final String? x_twitter;
  final String? threads;
  final String? linkedin;
  TeacherContactInfoEntity({
    required this.mobile,
    required this.mobileCountry,
    required this.whatsapp,
    required this.whatsappCountry,
    required this.bornDate,
    required this.gender,
    required this.countryResidence,
    required this.cityResidence,
    required this.nationality,
    required this.facebook,
    required this.instagram,
    required this.tiktok,
    required this.youtube,
    required this.x_twitter,
    required this.threads,
    required this.linkedin,
  });

  factory TeacherContactInfoEntity.empty() {
    return TeacherContactInfoEntity(
        mobile: '',
        whatsapp: '',
        bornDate: null,
        countryResidence: CountryEntity.empty(),
        cityResidence: null,
        mobileCountry: CountryEntity.empty(),
        whatsappCountry: CountryEntity.empty(),
        nationality: CountryEntity.empty(),
        gender: Gender.unspecified,
        facebook: null,
        instagram: null,
        linkedin: null,
        threads: null,
        tiktok: null,
        x_twitter: null,
        youtube: null);
  }
  @override
  List<Object?> get props => [
        mobile,
        mobileCountry,
        whatsapp,
        whatsappCountry,
        bornDate,
        gender,
        countryResidence,
        cityResidence,
        nationality,
        facebook,
        instagram,
        tiktok,
        youtube,
        x_twitter,
        threads,
        linkedin,
      ];

  TeacherContactInfoEntity copyWith({
    String? mobile,
    CountryEntity? mobileCountry,
    String? whatsapp,
    CountryEntity? whatsappCountry,
    DateTime? bornDate,
    Gender? gender,
    CountryEntity? countryResidence,
    CityEntity? cityResidence,
    CountryEntity? nationality,
    String? facebook,
    String? instagram,
    String? tiktok,
    String? youtube,
    String? x_twitter,
    String? threads,
    String? linkedin,
  }) {
    return TeacherContactInfoEntity(
      mobile: mobile ?? this.mobile,
      mobileCountry: mobileCountry ?? this.mobileCountry,
      whatsapp: whatsapp ?? this.whatsapp,
      whatsappCountry: whatsappCountry ?? this.whatsappCountry,
      bornDate: bornDate ?? this.bornDate,
      gender: gender ?? this.gender,
      countryResidence: countryResidence ?? this.countryResidence,
      cityResidence: cityResidence ?? this.cityResidence,
      nationality: nationality ?? this.nationality,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      tiktok: tiktok ?? this.tiktok,
      youtube: youtube ?? this.youtube,
      x_twitter: x_twitter ?? this.x_twitter,
      threads: threads ?? this.threads,
      linkedin: linkedin ?? this.linkedin,
    );
  }
}
