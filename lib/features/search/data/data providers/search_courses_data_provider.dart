import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/search/data/models/course_model.dart';
import 'package:khosousi_online/features/search/data/models/teacher_model.dart';
import 'package:khosousi_online/features/search/domain/entities/course_entity.dart';

abstract class SearchCoursesDataProvider {
  Future<List<CourseModel>> getCourses({
    required int start,
    required String? countryId,
    required String? cityId,
    required String? categoryId,
    required String? gender,
    required String? stage,
    required String? searchkeyword,
    required String teachMethod,
  });
}

class SearchCoursesDataProviderWithDio extends SearchCoursesDataProvider {
  final BaseApiService client;
  SearchCoursesDataProviderWithDio({
    required this.client,
  });

  @override
  Future<List<CourseModel>> getCourses({
    required int start,
    required String? countryId,
    required String? cityId,
    required String? categoryId,
    required String? gender,
    required String? stage,
    required String? searchkeyword,
    required String teachMethod,
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

    final res = await client.multipartRequest(
      url: EndPointsManager.getCoursesbyFilter,
      jsonBody: body,
    );

    List<CourseModel> data = [];
    int index = start;
    var jsonRes = res[0]['courses'];
    for (int i = 0; i < jsonRes.length; i++) {
      CourseModel courseModel = CourseModel.fromJson(jsonRes[i], i);
      data.add(courseModel);
      index++;
    }

    return data;
  }
}
