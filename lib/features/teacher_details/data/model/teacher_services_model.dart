// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_services_entity.dart';

class TeacherServicesModel extends TeacherServicesEntity {
  TeacherServicesModel(
      {required super.id,
      required super.title,
      required super.isVipService,
      required super.image,
      required super.countryAr,
      required super.countryEn,
      required super.cityAr,
      required super.cityEn,
      required super.categories});

  factory TeacherServicesModel.fromJson(Map<String, dynamic> map, int index) {
    dynamic info = map['service_info $index'];
    dynamic categories = map['service_categories $index'];
    return TeacherServicesModel(
      id: info['Id'] ?? '',
      title: info['Title'] ?? '',
      isVipService:
          info['Is_vip_service'] == null ? false : info['Is_vip_service'] == '1',
      image:  info['Image_path'] == null || (info['Image_path'] as String).isEmpty
          ? EndPointsManager.servicesDefaultImageBaseUrl
          : EndPointsManager.servicesImageBaseUrl + info['Image_path'],
      countryAr: info['Country_Name_ar']??'',
      countryEn: info['Country_Name_en'] ??'',
      cityAr: info['City_Name_ar'] ??'',
      cityEn: info['City_Name_en'] ??'',
      categories: (categories as List<dynamic>)
          .map(
            (e) => TeacherServicesCategoryModel.fromJson(e),
          )
          .toList(),
    );
  }
}

class TeacherServicesCategoryModel extends TeacherServicesCategoryEntity {
  TeacherServicesCategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });
  factory TeacherServicesCategoryModel.fromJson(Map<String, dynamic> map) {
    return TeacherServicesCategoryModel(
      id: map['Id'] ?? '',
      nameAr: map['Name_ar'] ?? '',
      nameEn: map['Name_en'] ?? '',
    );
  }
}
