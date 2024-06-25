import '../../../../core/api_service/base_api_service.dart';
import '../../../../core/managers/endpoints_manager.dart';
import '../models/notification_model.dart';

abstract class NotificationDataProvider {
  Future<List<NotificationModel>> getNotification({required String userId});
}

class NotificationDataProviderWithDio implements NotificationDataProvider {
  final BaseApiService client;
  NotificationDataProviderWithDio({
    required this.client,
  });

  Future<List<NotificationModel>> getNotification(
      {required String userId}) async {
    final res = await client.multipartRequest(
        url: EndPointsManager.notification, jsonBody: {'user_id': userId});
    List<NotificationModel> data = [];
    for (int i = 0; i < res.length; i++) {
      NotificationModel notificationModel = NotificationModel.fromJson(res[i],i);
      data.add(notificationModel);
    }
    return data;
  }
}
