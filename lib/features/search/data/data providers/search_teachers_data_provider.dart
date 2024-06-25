import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/search/data/models/course_model.dart';
import 'package:khosousi_online/features/search/data/models/teacher_model.dart';
import 'package:khosousi_online/features/search/domain/entities/course_entity.dart';

abstract class SearchTeacherDataProvider {
  Future<List<TeacherModel>> getTeachers({
    required int start,
    required String? countryId,
    required String? cityId,
    required String? categoryId,
    required String? gender,
    required String? stage,
    required String? searchkeyword,
    required String teachMethod,
    required double? lat,
    required double? lng,
  });
}

class SearchTeacherDataProviderWithDio extends SearchTeacherDataProvider {
  final BaseApiService client;
  SearchTeacherDataProviderWithDio({
    required this.client,
  });

  @override
  Future<List<TeacherModel>> getTeachers({
    required int start,
    required String? countryId,
    required String? cityId,
    required String? categoryId,
    required String? gender,
    required String? stage,
    required String? searchkeyword,
    required String teachMethod,
    required double? lat,
    required double? lng,
  }) async {
    Map<String, dynamic> body = {};
    body['start'] = start;
    body['Teach_method'] = teachMethod;
    body['country_id'] = countryId ?? '';
    body['city_id'] = cityId ?? '';
    body['gender'] = gender ?? '';
    body['stage'] = stage ?? '';
    body['search_key_word'] = searchkeyword ?? '';
    body['category_id'] = categoryId ?? '';
    if (lat != null) body['latitude'] = lat;
    if (lng != null) body['longitude'] = lng;

    final res = await client.multipartRequest(
      url: EndPointsManager.getTeachersbyFilter,
      jsonBody: body,
    );

    List<TeacherModel> data = [];
    int index = start;
    for (int i = 0; i < res.length; i++) {
      TeacherModel teacherModel = TeacherModel.fromJson(res[i], index);
      data.add(teacherModel);
      index++;
    }

    return data;
  }
}
