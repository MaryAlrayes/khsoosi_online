// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/shared_features/domain/entities/city_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';

class InstituteContactEnitity extends Equatable {
  final String mobile;
  final CountryEntity mobileCountry;
  final String whatsapp;
  final CountryEntity whatsappCountry;
  final DateTime? bornDate;

  final CountryEntity countryResidence;
  final CityEntity? cityResidence;
  final CountryEntity nationality;
  InstituteContactEnitity({
    required this.mobile,
    required this.mobileCountry,
    required this.whatsapp,
    required this.whatsappCountry,
    required this.bornDate,

    required this.countryResidence,
    required this.cityResidence,
    required this.nationality,
  });
  factory InstituteContactEnitity.empty() {
    return InstituteContactEnitity(
      mobile: '',
      whatsapp: '',
      bornDate: null,
      countryResidence: CountryEntity.empty(),
      cityResidence: null,
      mobileCountry: CountryEntity.empty(),
      whatsappCountry: CountryEntity.empty(),
      nationality: CountryEntity.empty(),

    );
  }
  @override
  List<Object?> get props => [
        mobile,
        mobileCountry,
        whatsapp,
        whatsappCountry,
        bornDate,

        countryResidence,
        cityResidence,
        nationality,
      ];

  InstituteContactEnitity copyWith({
    String? mobile,
    CountryEntity? mobileCountry,
    String? whatsapp,
    CountryEntity? whatsappCountry,
    DateTime? bornDate,

    CountryEntity? countryResidence,
    CityEntity? cityResidence,
    CountryEntity? nationality,
  }) {
    return InstituteContactEnitity(
      mobile: mobile ?? this.mobile,
      mobileCountry: mobileCountry ?? this.mobileCountry,
      whatsapp: whatsapp ?? this.whatsapp,
      whatsappCountry: whatsappCountry ?? this.whatsappCountry,
      bornDate: bornDate ?? this.bornDate,
   
      countryResidence: countryResidence ?? this.countryResidence,
      cityResidence: cityResidence ?? this.cityResidence,
      nationality: nationality ?? this.nationality,
    );
  }
}
