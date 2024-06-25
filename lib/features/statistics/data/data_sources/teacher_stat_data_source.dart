import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/statistics/data/models/teacher_stat_model.dart';

import '../../../../core/api_service/base_api_service.dart';
import '../models/student_stat_model.dart';

abstract class TeacherStatDataSource {
  Future<TeacherStatModel> getTeacherStat({required String userId});
    Future<StudentStatModel> getStudentStat({required String userId});
}

class TeacherStatDataSourceWithDio implements TeacherStatDataSource {
  final BaseApiService client;
  TeacherStatDataSourceWithDio({
    required this.client,
  });

  @override
   Future<TeacherStatModel> getTeacherStat({required String userId}) async {
    final res = await client.getRequest(
      url: EndPointsManager.statistics +userId,
    );

    TeacherStatModel teacherStatModel = TeacherStatModel.fromJson(res);

    return teacherStatModel;
  }
   Future<StudentStatModel> getStudentStat({required String userId})async{
     final res = await client.getRequest(
      url: EndPointsManager.statistics +userId,
    );

    StudentStatModel studentStatModel = StudentStatModel.fromJson(res);

    return studentStatModel;

   }
}
