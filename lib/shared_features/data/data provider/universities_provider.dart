import '../../../core/api_service/base_api_service.dart';
import '../../../core/managers/endpoints_manager.dart';
import '../models/university_model.dart';

abstract class UniversitiesDataSource {
  Future<List<UniversityModel>> fetchUniversities();
}

class UniversitiesDataSourceWithHttp implements UniversitiesDataSource {
  final BaseApiService client;
  UniversitiesDataSourceWithHttp({
    required this.client,
  });

  @override
  Future<List<UniversityModel>> fetchUniversities() async {
    final res = await client.getRequest(
      url: EndPointsManager.universities,
    );
    List<UniversityModel> data = [];

    res.forEach((element) {
      UniversityModel universityModel = UniversityModel.fromJson(element);

      data.add(universityModel);
    });
    return data;
  }
}
