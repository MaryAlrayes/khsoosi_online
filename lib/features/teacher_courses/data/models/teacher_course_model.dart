import 'package:khosousi_online/core/managers/endpoints_manager.dart';

import '../../domain/entities/teacher_course_entity.dart';

class TeacherCourseModel extends TeacherCourseEntity {
  TeacherCourseModel({
    required super.id,
    required super.name,
    required super.categories,
    required super.isActive,
    required super.isUpdated,
    required super.isAccepted,
    required super.isRejected,
    required super.isPending, required super.image,
  });

  factory TeacherCourseModel.fromJson(Map<String, dynamic> map, int index) {
    Map<String, dynamic> info = map['course_info $index'];
    List<dynamic> categories = map['course_categories $index'];

    return TeacherCourseModel(
      id: info['Id'] ?? '',
      name: info['Title'] ?? '',
      isActive: info['Is_active'] ?? '0',
      isUpdated: info['Is_updated'] ?? '0',
      isAccepted: info['Is_active'] == '1',
      isRejected: info['Is_active'] == '0' && info['Is_updated'] == '0',
      isPending: info['Is_active'] == '0' && info['Is_updated'] == '1',
      image:  info['Image_path'] == null || (info['Image_path'] as String).isEmpty
          ? EndPointsManager.coursesDefaultImageBaseUrl
          : EndPointsManager.coursesImageBaseUrl + info['Image_path'] ,
      categories: List.generate(
        categories.length,
        (index) => categories[index]['Name_ar'],
      ),
    );
  }
}
