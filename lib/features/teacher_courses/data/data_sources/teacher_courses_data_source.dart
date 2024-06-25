import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/teacher_courses/data/models/teacher_course_model.dart';

abstract class TeacherCoursesDataSource {
  Future<List<TeacherCourseModel>> getCourses({required String userId});
}

class TeacherCoursesDataSourceWithDio implements TeacherCoursesDataSource {
  final BaseApiService client;
  TeacherCoursesDataSourceWithDio({
    required this.client,
  });

  @override
  Future<List<TeacherCourseModel>> getCourses({required String userId}) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.teacher_courses,
      jsonBody: {'user_id': userId},
    );

    List<TeacherCourseModel> data = [];

    var jsonRes = res[0]['courses'];
    for (int i = 0; i < jsonRes.length; i++) {
      TeacherCourseModel courseModel =
          TeacherCourseModel.fromJson(jsonRes[i], i);
      data.add(courseModel);
    }

    return data;
  }
}
