import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/teacher_courses/data/models/teacher_course_model.dart';

import '../models/teacher_balance_model.dart';

abstract class TeacherBalanceDataSource {
  Future<TeacherBalanceModel> getBalance({required String userId});
}

class TeacherBalanceDataSourceWithDio implements TeacherBalanceDataSource {
  final BaseApiService client;
  TeacherBalanceDataSourceWithDio({
    required this.client,
  });

  @override
  Future<TeacherBalanceModel> getBalance({required String userId}) async {
    final res = await client.getRequest(
      url: EndPointsManager.teacher_balance+userId,
    );

    TeacherBalanceModel teacherBalanceModel = TeacherBalanceModel.fromJson(res);

    return teacherBalanceModel;
  }
}
