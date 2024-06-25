
import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/data/models/course_details_model.dart';

abstract class CourseDetailsDataProvider {
  Future<CourseDetailsModel> getCourseDetails({required String id});
}

class CourseDetailsDataProviderWithDio extends CourseDetailsDataProvider {
  final BaseApiService client;
  CourseDetailsDataProviderWithDio({
    required this.client,
  });

  @override
 Future<CourseDetailsModel> getCourseDetails({required String id}) async {
    final res = await client.getRequest(
      url: EndPointsManager.courseDetailsBaseUrl+'$id',
    );
    CourseDetailsModel data = CourseDetailsModel.fromJson(res);


    return data;
  }
}
