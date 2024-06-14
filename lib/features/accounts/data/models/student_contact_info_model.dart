// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/accounts/domain/entities/student_contact_info_entity.dart';

import '../../../../core/utils/enums/enums.dart';

class StudentContactInfoModel extends StudentContactInfoEntity {
  StudentContactInfoModel(
      {required super.mobile,
      required super.mobileCountry,
      required super.whatsapp,
      required super.whatsappCountry,
      required super.gender,
      required super.bornDate,
      required super.countryResidence});

  Map<String, dynamic> toJson({required String userId}) {
    return <String, dynamic>{
      'user_id': userId,
      'Mobile': mobile,
      'Mobile_country_id': mobileCountry.id,
      'Whatsapp': whatsapp,
      'Whatsapp_country_id': whatsappCountry.id,
      'Born_date': '${bornDate!.year}-${bornDate!.month}-${bornDate!.day}',
      if (gender != Gender.unspecified) 'jender': gender.getValueForApi(),
      'Residence': countryResidence.id,
    };
  }
}
