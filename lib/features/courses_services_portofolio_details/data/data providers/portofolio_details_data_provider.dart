
import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/data/models/service_details_model.dart';

import '../models/portofolio_details_model.dart';

abstract class PortofolioDetailsDataProvider {
  Future<PortofolioDetailsModel> getPortofolioDetails({required String id});
}

class PortofolioDetailsDataProviderWithDio extends PortofolioDetailsDataProvider {
  final BaseApiService client;
  PortofolioDetailsDataProviderWithDio({
    required this.client,
  });

  @override
 Future<PortofolioDetailsModel> getPortofolioDetails({required String id}) async {
    final res = await client.getRequest(
      url: EndPointsManager.portofolioDetailsBaseUrl+'$id',
    );
    PortofolioDetailsModel data = PortofolioDetailsModel.fromJson(res);


    return data;
  }
}
