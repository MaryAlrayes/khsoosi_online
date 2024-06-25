
import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';

import '../models/teacher_portofolio_model.dart';

abstract class TeacherPortofoliosDataSource {
  Future<List<TeacherPortofolioModel>> getPortofolio({required String userId});
}

class TeacherPortofoliosDataSourceWithDio implements TeacherPortofoliosDataSource {
  final BaseApiService client;
  TeacherPortofoliosDataSourceWithDio({
    required this.client,
  });

  @override
   Future<List<TeacherPortofolioModel>> getPortofolio({required String userId})async{
  final res = await client.getRequest(
      url: EndPointsManager.teacher_portofolio+'$userId',

    );

    List<TeacherPortofolioModel> data = [];

    var jsonRes = res[0]['portfolio'];
    for (int i = 0; i < jsonRes.length; i++) {
      TeacherPortofolioModel portofolioModel =
          TeacherPortofolioModel.fromJson(jsonRes[i], i);
      data.add(portofolioModel);
    }

    return data;
  }
}

