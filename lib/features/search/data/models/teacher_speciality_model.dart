import 'package:khosousi_online/features/search/domain/entities/teacher_speciality_entity.dart';

class TeacherSpecialityModel extends TeacherSpecialityEntity {
  TeacherSpecialityModel({
    required super.id,
    required super.nameAr,
    required super.nameEng,
  });
  factory TeacherSpecialityModel.fromJson(Map<String, dynamic> json) {
    return TeacherSpecialityModel(
      id: json['Id'] ?? '',
      nameAr: json['Name_ar']??'',
      nameEng: json['Name_en']??'',
    );
  }
}
