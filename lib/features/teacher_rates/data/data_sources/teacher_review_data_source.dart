import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';

import '../models/teacher_review_model.dart';

abstract class TeacherReviewDataSource {
Future<List<TeacherReviewModel>> getReviews({required String userId});
}
class TeacherReviewDataSourceWithDio implements TeacherReviewDataSource{
  final BaseApiService client;
  TeacherReviewDataSourceWithDio({
    required this.client,
  });

  @override
  Future<List<TeacherReviewModel>> getReviews({required String userId})async {
    final res = await client.getRequest(
      url: EndPointsManager.teacher_review+'$userId',

    );

    List<TeacherReviewModel> data = [];

    var jsonRes = res[0]['reviews'];
    for (int i = 0; i < jsonRes.length; i++) {
      TeacherReviewModel review =
          TeacherReviewModel.fromJson(jsonRes[i], i);
      data.add(review);
    }

    return data;
  }
}
