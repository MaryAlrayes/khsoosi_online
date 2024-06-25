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

    Map<String, dynamic> institute = map['institute_info $index'];
    List<dynamic> categories = map['institute_categories $index'];
    return InstituteModel(
        id: institute['Id'] ?? '',
        title: institute['Name'] ?? '',
        countryAr: institute['country_name_ar'] ?? '',
        // cityAr: course['City_Name_ar'] ?? '',
        cityAr: '',
        imagePath: institute['Image_path'] == null ||
                (institute['Image_path'] as String).isEmpty
            ? EndPointsManager.coursesDefaultImageBaseUrl
            : EndPointsManager.coursesImageBaseUrl + institute['Image_path'],
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
