// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';

import '../../domain/entities/institute_details_course_entity.dart';

class InstituteDetailsCourseModel extends InstituteDetailsCourseEntity {
  InstituteDetailsCourseModel(
      {required super.id,
      required super.title,
        required super.image,
      required super.rate,
      required super.duration,
      required super.lectureNumber,
      required super.categories});

  factory InstituteDetailsCourseModel.fromJson(
      Map<String, dynamic> map, int index) {
    Map<String, dynamic> course =
        map['course_info $index'] as Map<String, dynamic>;
    List<dynamic> categories =
        map['course_categories $index'] as List<dynamic>;
    return InstituteDetailsCourseModel(
        id: course['Id'] ?? '',
        title: course['Title'] ?? '',
        //Todo:missing rate from API
        rate: course['rate'] ?? 1,
        //Todo:missing time from API
        duration: course['time'] ?? '12h 56m',
        //Todo:missing number of lecture from API
        lectureNumber: course['lectureNumber'] ?? 12,
      image:course['Image_path'] == null || (course['Image_path'] as String).isEmpty
          ? EndPointsManager.coursesDefaultImageBaseUrl
          : EndPointsManager.coursesImageBaseUrl + course['Image_path'],

        categories: (categories as List<dynamic>)
            .map(
              (e) => InstituteDetailsCourseCategoryModel.fromJson(e),
            )
            .toList());
  }
}

class InstituteDetailsCourseCategoryModel
    extends InstituteDetailsCourseCategoryEntity {
  InstituteDetailsCourseCategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

    factory InstituteDetailsCourseCategoryModel.fromJson(Map<String, dynamic> map) {
    return InstituteDetailsCourseCategoryModel(
      id: map['Id'] ??'',
      nameAr: map['Name_ar'] ??'',
      nameEn: map['Name_en']??'',
    );
  }
}
