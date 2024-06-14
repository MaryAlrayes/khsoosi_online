// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/accounts/domain/entities/teacher_extra_info_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/city_entity.dart';

import '../../../../shared_features/domain/entities/country_entity.dart';

class TeacherExtraInfoModel extends TeacherExtraInfoEntity {
  TeacherExtraInfoModel(
      {super.teacheOnline,
      super.teachHouse,
      super.teachElementry,
      super.teachPreparatory,
      super.teachSecondary,
      super.teachUniversity,
      super.address,
      required super.certificates,
      required super.skills,
      required super.categories});

  Map<String, dynamic> toJson({required String userId}) {
    Map<String, dynamic> data = {
      'user_id': userId,
      'Teach_method_internet': teacheOnline,
      'Teach_method_studentHouse': teachHouse,
      'Teach_method_teacherHouse': teachHouse,
      'Stage_elementry': teachElementry,
      'Stage_preparatory': teachPreparatory,
      'Stage_secondary': teachSecondary,
      'Stage_university': teachUniversity,
      'Address': address,
      'Certifications': certificates,
      'Skills': skills,
    };

    for (int i = 0; i < categories.length; i++) {
      data['User_category[${i + 1}]'] = categories[i].id;
    }
    return data;
  }
}
