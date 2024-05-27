// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/search/domain/entities/course_entity.dart';

class CourseModel extends CourseEntity {
  CourseModel(
      {required super.id,
      required super.title,
      required super.countryAr,
      required super.cityAr,
      required super.imagePath,
      required super.isVipCourse,
      required super.publisherUserId,
      required super.categories});

  factory CourseModel.fromJson(Map<String, dynamic> map, int index) {

    Map<String, dynamic> course = map['course_info $index'];
    List<dynamic> categories = map['course_categories $index'];
    return CourseModel(
        id: course['Id'] ??'',
        title: course['Title'] ??'',
        countryAr: course['Country_Name_ar'] ??'',
        cityAr: course['City_Name_ar'] ??'',
        imagePath:course['Image_path'] == null || (course['Image_path'] as String).isEmpty
          ? EndPointsManager.coursesDefaultImageBaseUrl
          : EndPointsManager.coursesImageBaseUrl + course['Image_path'] ,
        isVipCourse: course['Is_vip_course'] == '1',
        publisherUserId: course['Publisher_user_id']??'',
        categories: List.generate(
          categories.length,
          (index) => CourseCategoryModel.fromJson(
            categories[index],
          ),
        ));
  }
}

class CourseCategoryModel extends CourseCategoryEntity {
  CourseCategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEng,
  });
  factory CourseCategoryModel.fromJson(Map<String, dynamic> map) {
    return CourseCategoryModel(
      id: map['Id'] as String,
      nameAr: map['Name_ar'] as String,
      nameEng: map['Name_en'] as String,
    );
  }
}
