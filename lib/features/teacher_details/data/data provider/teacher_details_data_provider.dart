import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/teacher_details/data/model/teacher_details_model.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/services/shared_preferences.dart';

abstract class TeacherDetailsDataProvider {
  Future<TeacherDetailsModel> getTeacherDetails({required String id});
  Future<String> getTeacherPhones(
      {required String teacherId,
      required TeacherPhones type,
      required String? requesterId,
      required String requesterFingerPrint,
      required bool isLoggedIn});
}

class TeacherDetailsDataProviderWithDio extends TeacherDetailsDataProvider {
  final BaseApiService client;
  TeacherDetailsDataProviderWithDio({
    required this.client,
  });

  @override
  Future<TeacherDetailsModel> getTeacherDetails({required String id}) async {
    final res = await client.getRequest(
      url: EndPointsManager.getTeachersDetails + '?user_id=$id',
    );

    TeacherDetailsModel detailsModel = TeacherDetailsModel.fromJson(res);
    return detailsModel;
  }

  @override
  Future<String> getTeacherPhones(
      {required String teacherId,
      required TeacherPhones type,
      required String? requesterId,
      required String requesterFingerPrint,
      required bool isLoggedIn}) async {
    var jsonBody = {
      'Teacher_user_id': teacherId,
      'Type': type.getValueForApi(),
      'Requester_id': requesterId ?? '0',
      'Requester_fingerprint': '',
      'is_logged_in': isLoggedIn ? '1' : '0'
    };
    //get the saved cookie
    final mobile_query = PreferenceUtils.getString('mobile_queries');
    //add it to the body if it is not null
    if (mobile_query != null) {
      jsonBody['mobile_queries'] = mobile_query;
    }
    final res = await client.multipartRequest(
        url: EndPointsManager.teacherPhones,
        jsonBody: jsonBody,
        headers: {'X-Requested-With': 'XMLHttpRequest'},
        saveCookies: true,
        cookieName: 'mobile_queries');

    if (res['status'] == true) {
      return res['number'] as String;
    } else {
      throw NetworkErrorFailure(
        message: res['message'],
      );
    }
  }
}
