// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/city_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';

class SearchFilterEntity extends Equatable {
  final TeachingMethod? teachingMethod;
  final EducationalLevel? educationalLevel;
  final CategoryEntity? speciality;
  final LocationType? locationType;
  final double? lat;
  final double? lng;
  final CountryEntity? country;
  final CityEntity? city;
  final Gender? gender;
  final String? keyword;
  SearchFilterEntity({
    this.teachingMethod,
    this.educationalLevel,
    this.speciality,
    this.locationType,
    this.lat,
    this.lng,
    this.country,
    this.city,
    this.gender,
    this.keyword,
  });
  factory SearchFilterEntity.empty() {
    return SearchFilterEntity(
      teachingMethod: TeachingMethod.presence,
      educationalLevel: EducationalLevel.unspecified,
      speciality: null,
      lat: null,
      lng: null,
      locationType: null,
      city: null,
      country: null,
      gender: Gender.unspecified,
      keyword: null,
    );
  }
  @override
  List<Object?> get props => [
        teachingMethod,
        educationalLevel,
        speciality,
        locationType,
        lat,
        lng,
        country,
        city,
        gender,
        keyword,
      ];

  SearchFilterEntity copyWith({
    TeachingMethod? teachingMethod,
    EducationalLevel? educationalLevel,
    CategoryEntity? speciality,
    LocationType? locationType,
    double? lat,
    double? lng,
    CountryEntity? country,
    CityEntity? city,
    Gender? gender,
    String? keyword,
  }) {
    print('in copy with $lat');
    SearchFilterEntity searchFilterEntity = SearchFilterEntity(
      teachingMethod: teachingMethod ?? this.teachingMethod,
      educationalLevel: educationalLevel ?? this.educationalLevel,
      locationType: locationType ?? this.locationType,
      lat: lat??this.lat,
      lng: lng??this.lng,
      speciality: speciality ?? this.speciality,
      country: country ?? this.country,
      city: city ?? this.city,
      gender: gender ?? this.gender,
      keyword: keyword ?? this.keyword,
    );
 print('after in copy with ${searchFilterEntity.lat}');
    return searchFilterEntity;
  }
}
