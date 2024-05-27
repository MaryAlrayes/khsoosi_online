import 'package:equatable/equatable.dart';

import '../../domain/entities/course_service_details_category_entity.dart';

class CourseDetailsCategoryModel extends CourseServiceDetailsCategoryEntity {
  CourseDetailsCategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });
    factory CourseDetailsCategoryModel.fromJson(Map<String, dynamic> map) {
    return CourseDetailsCategoryModel(
      id: map['Id'] ??'',
      nameAr: map['Name_ar'] ??'',
      nameEn: map['Name_en']??'',
    );
  }

}
