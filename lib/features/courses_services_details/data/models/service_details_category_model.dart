import 'package:khosousi_online/features/courses_services_details/domain/entities/course_service_details_category_entity.dart';

class ServiceDetailsCategoryModel extends CourseServiceDetailsCategoryEntity {
  ServiceDetailsCategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });
  factory ServiceDetailsCategoryModel.fromJson(Map<String, dynamic> map) {
    return ServiceDetailsCategoryModel(
      id: map['Id'] ??'',
      nameAr: map['Name_ar'] ??'',
      nameEn: map['Name_en']??'',
    );
  }
}
