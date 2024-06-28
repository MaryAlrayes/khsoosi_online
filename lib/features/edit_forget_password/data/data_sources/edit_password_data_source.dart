import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';

abstract class ChangePasswordProvider {
  Future<Unit> changePassword({
    required String userId,
    required String oldPassowrd,
    required String newPassword,
    required String confirmPassword,
  });
}

class ChangePasswordProviderWithDio extends ChangePasswordProvider {
  final BaseApiService client;
  ChangePasswordProviderWithDio({
    required this.client,
  });

  @override
  Future<Unit> changePassword({
    required String userId,
    required String oldPassowrd,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.changePassword,
      jsonBody: {
        'user_id':userId,
        'currentpassword':oldPassowrd,
        'newpassword':newPassword,
        'newpasswordconfirm':confirmPassword
      },
    );
    if (res['status'] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(
        message: res['error messages'],
      );
    }
  }
}
