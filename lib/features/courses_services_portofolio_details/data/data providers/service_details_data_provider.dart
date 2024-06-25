
import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/data/models/service_details_model.dart';

abstract class ServiceDetailsDataProvider {
  Future<ServiceDetailsModel> getServiceDetails({required String id});
}

class ServiceDetailsDataProviderWithDio extends ServiceDetailsDataProvider {
  final BaseApiService client;
  ServiceDetailsDataProviderWithDio({
    required this.client,
  });

  @override
 Future<ServiceDetailsModel> getServiceDetails({required String id}) async {
    final res = await client.getRequest(
      url: EndPointsManager.serviceDetailsBaseUrl+'$id',
    );
    ServiceDetailsModel data = ServiceDetailsModel.fromJson(res);


    return data;
  }
}
