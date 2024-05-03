// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_courses_entity.dart';

class TeacherCoursesModel extends TeacherCoursesEntity {
  TeacherCoursesModel(
      {required super.id,
      required super.title,
      required super.isVipCourse,
      required super.image,
      required super.presense,
      required super.online,
      required super.categories});

  factory TeacherCoursesModel.fromJson(Map<String, dynamic> map, int index) {
    dynamic info = map['course_info $index'];
    dynamic categories = map['course_categories $index'];
    return TeacherCoursesModel(
      id: info['Id'] ?? '',
      title: info['Title'] ?? '',
      isVipCourse:
          info['Is_vip_course'] == null ? false : info['Is_vip_course'] == '1',
      image: info['Image_path'] == null || (info['Image_path'] as String).isEmpty
          ? EndPointsManager.coursesDefaultImageBaseUrl
          : EndPointsManager.coursesImageBaseUrl + info['Image_path'],
      presense: info['Teach_method_teacherHouse'] == null &&
              info['Teach_method_studentHouse'] == null
          ? false
          : (info['Teach_method_teacherHouse'] == '1' ||
              info['Teach_method_studentHouse'] == '1'),
      online: info['Teach_method_internet'] == null
          ? false
          : info['Teach_method_internet'] == '1',
      categories: (categories as List<dynamic>)
          .map(
            (e) => TeacherCourseCategoryModel.fromJson(e),
          )
          .toList(),
    );
  }
}

class TeacherCourseCategoryModel extends TeacherCourseCategoryEntity {
  TeacherCourseCategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory TeacherCourseCategoryModel.fromJson(Map<String, dynamic> map) {
    return TeacherCourseCategoryModel(
      id: map['Id'] ?? '',
      nameAr: map['Name_ar'] ?? '',
      nameEn: map['Name_en'] ?? '',
    );
  }
}
