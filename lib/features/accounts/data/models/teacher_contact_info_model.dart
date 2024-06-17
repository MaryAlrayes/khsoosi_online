// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/accounts/domain/entities/teacher_contact_info_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/city_entity.dart';

import '../../../location/domain/entities/country_entity.dart';

class TeacherContactInfoModel extends TeacherContactInfoEntity {
  TeacherContactInfoModel({
    required super.mobile,
    required super.mobileCountry,
    required super.whatsapp,
    required super.whatsappCountry,
    required super.bornDate,
    required super.gender,
    required super.countryResidence,
    required super.cityResidence,
    required super.nationality,
    required super.facebook,
    required super.instagram,
    required super.tiktok,
    required super.youtube,
    required super.x_twitter,
    required super.threads,
    required super.linkedin,
  });

  Map<String, dynamic> toJson({required String userId}) {
    return <String, dynamic>{
      'user_id': userId,
      'Mobile': mobile,
      'Mobile_country_id': mobileCountry.id,
      'Whatsapp': whatsapp,
      'Whatsapp_country_id': whatsappCountry.id,
      'Born_date': '${bornDate!.year}-${bornDate!.month}-${bornDate!.day}',
      if (gender != Gender.unspecified) 'jender': gender.getValueForApi(),
      'Nationality': nationality.id,
      'Residence': countryResidence.id,
      if (cityResidence != null) 'City': cityResidence!.id,
      if (instagram != null) 'Instagram_profile': instagram,
      if (facebook != null) 'facebook_profile': facebook,
      if (tiktok != null) 'titktok_profile': tiktok,
      if (youtube != null) 'youtube_channel': youtube,
      if (x_twitter != null) 'x_profile': x_twitter,
      if (threads != null) 'threads_profile': threads,
      if (linkedin != null) 'linkedin_profile': linkedin
    };
  }
}
