import 'package:khosousi_online/features/search/domain/entities/teacher_category_entity.dart';

class TeacherCategoryModel extends TeacherCategoryEntity {
  TeacherCategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEng,
  });
  factory TeacherCategoryModel.fromJson(Map<String, dynamic> json,) {
    return TeacherCategoryModel(
      id: json['Id'] ?? '',
      nameAr: json['Name_ar']??'',
      nameEng: json['Name_en']??'',
    );
  }
}
