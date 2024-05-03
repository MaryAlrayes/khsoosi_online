import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/teacher_details/data/model/teacher_details_model.dart';

abstract class TeacherDetailsDataProvider {
  Future<TeacherDetailsModel> getTeacherDetails({required String id});
}

class TeacherDetailsDataProviderWithDio extends TeacherDetailsDataProvider {
  final BaseApiService client;
  TeacherDetailsDataProviderWithDio({
    required this.client,
  });

  @override
  Future<TeacherDetailsModel> getTeacherDetails({required String id}) async {
    final res = await client.getRequest (
      url: EndPointsManager.getTeachersDetails+'?user_id=$id',
    );
    
    TeacherDetailsModel detailsModel = TeacherDetailsModel.fromJson(res);
    return detailsModel;
  }

}
