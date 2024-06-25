import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/assistence/data/models/article_model.dart';

import '../../../../core/api_service/base_api_service.dart';

abstract class AssistenceDataSource {
  Future<List<ArticleModel>> getArticles({required int start});
}

class AssistenceDataSourceWithDio implements AssistenceDataSource {
  final BaseApiService client;
  AssistenceDataSourceWithDio({
    required this.client,
  });
  Future<List<ArticleModel>> getArticles({required int start}) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.faq,
      jsonBody: {'start': start},
    );

    List<ArticleModel> data = [];

    for (int i = 0; i < res['articles'].length; i++) {
      ArticleModel articleModel =
          ArticleModel.fromJson(res['articles'][i], );
      data.add(articleModel);

    }

    return data;
  }
}
