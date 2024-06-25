import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_details_teacher_entity.dart';

class CourseDetailsTeacherModel extends CourseServiceDetailsTeacherEntity {
  CourseDetailsTeacherModel(
      {required super.teacherId,
      required super.name,
      required super.userName,
      required super.imagePath,
      required super.teachOnline,
      required super.teachPresence,
      required super.teacherRate,
      required super.coursesNumber,
      required super.description, required super.certifications});

  factory CourseDetailsTeacherModel.fromJson(
      Map<String, dynamic> map, int coursesCount, double? averageRate) {
    return CourseDetailsTeacherModel(
      teacherId: map['Id'] ?? "",
      name: map['Name'] ?? '',
      userName: map['User_name'] ?? '',
      imagePath:
          map['Image_path'] == null || (map['Image_path'] as String).isEmpty
              ? map['Jender'] == '0'
                  ? EndPointsManager.maleUserDefaultImageBaseUrl
                  : EndPointsManager.femaleUserDefaultImageBaseUrl
              : EndPointsManager.userImageBaseUrl + map['Image_path'],
      teachOnline: map['Teach_method_internet'] == null
          ? false
          : map['Teach_method_internet'] == '1',
      teachPresence: map['Teach_method_studentHouse'] == '1' ||
          map['Teach_method_teacherHouse'] == '1' ||
          map['root_by_offline_method_T'] == '1',
      teacherRate: averageRate,
      coursesNumber: coursesCount,
      description: map['Skills'] ??'',
      certifications:map['Certifications']??'',
    );
  }
}
