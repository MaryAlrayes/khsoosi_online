import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/search/data/models/course_model.dart';
import 'package:khosousi_online/features/search/data/models/institute_model.dart';
import 'package:khosousi_online/features/search/data/models/teacher_model.dart';
import 'package:khosousi_online/features/search/domain/entities/course_entity.dart';

abstract class SearchInstitutesDataProvider {
  Future<List<InstituteModel>> getInstitutes({
    required int start,
    required String? countryId,
    required String? cityId,
    required String? categoryId,

  });
}

class SearchInstitutesDataProviderWithDio extends SearchInstitutesDataProvider {
  final BaseApiService client;
  SearchInstitutesDataProviderWithDio({
    required this.client,
  });

  @override
   Future<List<InstituteModel>> getInstitutes({
    required int start,
    required String? countryId,
    required String? cityId,
    required String? categoryId,

  })async {
    Map<String, dynamic> body = {};
    body['start'] = start;
      //TODO: MISSING country id , city id ,category FROM API
    // body['country_id'] = countryId ?? '';
    // body['city_id'] = cityId ?? '';
    // body['category_id'] = categoryId ?? '';

    final res = await client.multipartRequest(
      url: EndPointsManager.getInstitutesbyFilter,
      jsonBody: body,
    );

    List<InstituteModel> data = [];
    int index = start;
    var jsonRes = res[0]['institutes'];
    for (int i = 0; i < jsonRes.length; i++) {
      InstituteModel instituteModel = InstituteModel.fromJson(jsonRes[i], index);
      data.add(instituteModel);
      index++;
    }

    return data;
  }
}
