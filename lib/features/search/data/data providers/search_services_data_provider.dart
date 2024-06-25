import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/search/data/models/course_model.dart';
import 'package:khosousi_online/features/search/data/models/service_model.dart';
import 'package:khosousi_online/features/search/data/models/teacher_model.dart';
import 'package:khosousi_online/features/search/domain/entities/course_entity.dart';

abstract class SearchServicesDataProvider {
  Future<List<ServiceModel>> getServices({
    required int start,
    required String? countryId,
    required String? cityId,
    required String? searchkeyword,
  });
}

class SearchServicesDataProviderWithDio extends SearchServicesDataProvider {
  final BaseApiService client;
  SearchServicesDataProviderWithDio({
    required this.client,
  });

  Future<List<ServiceModel>> getServices({
    required int start,
    required String? countryId,
    required String? cityId,
    required String? searchkeyword,
  }) async {
    Map<String, dynamic> body = {};
    body['start'] = start;
    body['country_id'] = countryId ?? '';
    body['city_id'] = cityId ?? '';
    body['search_key_word'] = searchkeyword ?? '';

    final res = await client.multipartRequest(
      url: EndPointsManager.getServicesbyFilter,
      jsonBody: body,
    );

    List<ServiceModel> data = [];
    int index = start;
    var jsonRes = res[0]['services'];
    for (int i = 0; i < jsonRes.length; i++) {
      ServiceModel serviceModel = ServiceModel.fromJson(jsonRes[i], i);
      data.add(serviceModel);
      index++;
    }

    return data;
  }
}
