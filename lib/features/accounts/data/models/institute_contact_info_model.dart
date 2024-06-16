// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/accounts/domain/entities/institute_contact_info_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/city_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';

class InstituteContactModel extends InstituteContactEnitity {
  InstituteContactModel(
      {required super.mobile,
      required super.mobileCountry,
      required super.whatsapp,
      required super.whatsappCountry,
      required super.bornDate,

      required super.countryResidence,
      required super.cityResidence,
      required super.nationality});

      Map<String, dynamic> toJson({required String userId}) {
    return <String, dynamic>{
      'user_id': userId,
      'Mobile': mobile,
      'Mobile_country_id': mobileCountry.id,
      'Whatsapp': whatsapp,
      'Whatsapp_country_id': whatsappCountry.id,
      'Born_date': '${bornDate!.year}-${bornDate!.month}-${bornDate!.day}',
      'Nationality': nationality.id,
      'Residence': countryResidence.id,
      if (cityResidence != null) 'City': cityResidence!.id,

    };
  }
}
