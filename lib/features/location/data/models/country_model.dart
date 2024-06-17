//         "Id": "1",
//         "country_code": "AF",
//         "country_name_en": "Afghanistan",
//         "country_name_en_url": "Afghanistan",
//         "country_name_ar": "",
//         "calling_code": "93"
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  CountryModel(
      {required super.id,
      required super.countryCode,
      required super.countryNameEn,
      required super.country_name_en_url,
      required super.countryNameAr,
      required super.callingCode});

  factory CountryModel.fromJson(Map<String, dynamic> map) {
    return CountryModel(
      id: map['Id'] as String,
      countryCode: map['country_code'] as String,
      countryNameEn: map['country_name_en'] as String,
      country_name_en_url: map['country_name_en_url'] as String,
      countryNameAr: map['country_name_ar'] as String,
      callingCode: map['calling_code'] as String,
    );
  }

  @override
  bool get stringify => true;
}
