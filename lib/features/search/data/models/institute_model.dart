// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/search/domain/entities/institute_entity.dart';

class InstituteModel extends InstituteEntity {
  InstituteModel({
    required super.id,
    required super.title,
    required super.countryAr,
    required super.cityAr,
    required super.imagePath,
    required super.categories,
  });

  factory InstituteModel.fromJson(Map<String, dynamic> map, int index) {
//Todo: parse the json
    Map<String, dynamic> course = map['course_info $index'];
    List<dynamic> categories = map['course_categories $index'];
    return InstituteModel(
        id: course['Id'] ?? '',
        title: course['Title'] ?? '',
        countryAr: course['Country_Name_ar'] ?? '',
        cityAr: course['City_Name_ar'] ?? '',
        imagePath: course['Image_path'] == null ||
                (course['Image_path'] as String).isEmpty
            ? EndPointsManager.coursesDefaultImageBaseUrl
            : EndPointsManager.coursesImageBaseUrl + course['Image_path'],
        categories: List.generate(
          categories.length,
          (index) => InstituteCategoryModel.fromJson(
            categories[index],
          ),
        ));
  }
}

class InstituteCategoryModel extends InstituteCategoryEntity {
  InstituteCategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEng,
  });

  factory InstituteCategoryModel.fromJson(Map<String, dynamic> map) {
    return InstituteCategoryModel(
      id: map['Id'] as String,
      nameAr: map['Name_ar'] as String,
      nameEng: map['Name_en'] as String,
    );
  }
}
