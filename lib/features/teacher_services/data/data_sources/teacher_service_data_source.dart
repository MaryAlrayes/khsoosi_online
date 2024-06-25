import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/teacher_services/data/models/teacher_service_model.dart';

abstract class TeacherServicesDataSource {
  Future<List<TeacherServiceModel>> getServices({required String userId});
}

class TeacherServicesDataSourceWithDio implements TeacherServicesDataSource {
  final BaseApiService client;
  TeacherServicesDataSourceWithDio({
    required this.client,
  });

  @override
  Future<List<TeacherServiceModel>> getServices({required String userId}) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.teacher_services,
      jsonBody: {'user_id': userId},
    );

    List<TeacherServiceModel> data = [];

    var jsonRes = res[0]['services'];
    for (int i = 0; i < jsonRes.length; i++) {
      TeacherServiceModel service =
          TeacherServiceModel.fromJson(jsonRes[i], i);
      data.add(service);
    }

    return data;
  }
}
