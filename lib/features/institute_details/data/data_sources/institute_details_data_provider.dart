import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/institute_details/data/models/institute_details_model.dart';

abstract class InstituteDetailsDataProvider{
   Future<InstituteDetailsModel> getInstituteDetails({required String id});
}

class InstituteDetailsDataProviderWithDio extends InstituteDetailsDataProvider {
  final BaseApiService client;
  InstituteDetailsDataProviderWithDio({
    required this.client,
  });


  @override
  Future<InstituteDetailsModel> getInstituteDetails({required String id})async {
     final res = await client.getRequest(
      url: EndPointsManager.instituteDetailsBaseUrl+'$id',
    );
    InstituteDetailsModel data = InstituteDetailsModel.fromJson(res);


    return data;
  }
}
