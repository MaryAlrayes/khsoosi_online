import 'package:khosousi_online/shared_features/domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  CityModel(
      {required super.id,
      required super.nameEn,
      required super.nameAr,
      required super.countryId});



  factory CityModel.fromJson(Map<String, dynamic> map) {
    return CityModel(
      id: map['Id'] as String,
      nameEn: map['Name_en'] as String,
      nameAr: map['Name_ar'] as String,
      countryId: map['Country_id'] as String,
    );
  }

}
