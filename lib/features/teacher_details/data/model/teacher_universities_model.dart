import 'package:equatable/equatable.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_universities_entity.dart';

class TeacherUniversitiesModel extends TeacherUniversitiesEntity {
  TeacherUniversitiesModel(
      {required super.id,
      required super.universityNameAr,
      required super.universityNameEn,
      required super.countryAr});

  factory TeacherUniversitiesModel.fromJson(Map<String, dynamic> map) {
    return TeacherUniversitiesModel(
      id: map['universityId'] ??'',
      universityNameAr: map['universityName'] ??'',
      universityNameEn: map['universityNameEn'] ??'',
      countryAr: map['Country_name_ar'] ??'',
    );
  }
}
