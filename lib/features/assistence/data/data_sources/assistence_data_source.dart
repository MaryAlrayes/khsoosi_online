import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/assistence/data/models/article_model.dart';

import '../../../../core/api_service/base_api_service.dart';
import '../models/support_message_model.dart';

abstract class AssistenceDataSource {
  Future<List<ArticleModel>> getArticles();
  Future<List<SupportMessageModel>> getSupportMessages({required String id,required int start});
    Future<String> sendMessage({required String id,required String message});

}

class AssistenceDataSourceWithDio implements AssistenceDataSource {
  final BaseApiService client;
  AssistenceDataSourceWithDio({
    required this.client,
  });
  Future<List<ArticleModel>> getArticles() async {
    final res = await client.multipartRequest(
      url: EndPointsManager.faq,
      jsonBody: {},
    );

    List<ArticleModel> data = [];

    for (int i = 0; i < res['articles'].length; i++) {
      ArticleModel articleModel =
          ArticleModel.fromJson(res['articles'][i], );
      data.add(articleModel);

    }

    return data;
  }

  @override
  Future<List<SupportMessageModel>> getSupportMessages({required String id, required int start})async {
    final res = await client.multipartRequest(
      url: EndPointsManager.getSupportMessages,
      jsonBody: {'start':start,'user_id':id},
    );

    List<SupportMessageModel> data = [];

    for (int i = 0; i < res.length; i++) {
      SupportMessageModel supportMessageModel =
          SupportMessageModel.fromJson(res[i], );
      data.add(supportMessageModel);

    }

    return data;
  }

  @override
  Future<String> sendMessage({required String id, required String message})async {
   final res = await client.multipartRequest(
      url: EndPointsManager.submitMessage,
      jsonBody: {'Message':message,'user_id':id},
    );



    return (res as int).toString();
  }
}
