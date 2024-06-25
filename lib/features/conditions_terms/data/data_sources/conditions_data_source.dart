import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';

abstract class ConditionsDataProvider {
  Future<Unit> answerConditions({required String userId,required bool Conditions});
}

 class ConditionsDataProviderWithDio implements ConditionsDataProvider{

    final BaseApiService client;
  ConditionsDataProviderWithDio({
    required this.client,
  });
  @override
  Future<Unit> answerConditions({required String userId, required bool Conditions})async {
   final res = await client.multipartRequest(
      url: EndPointsManager.conditions,
      jsonBody: {
        'user_id':userId,
        'Conditions':Conditions?'1':'0'

      },
    );
    if (res['status'] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['error messages'] as Map<String, dynamic>;
      List<String> keys = (errors).keys.toList();
      keys.forEach((e) {
        if (errors[e].isNotEmpty) {
          errorMessage += errors[e] + '\n';
        }
      });
      throw NetworkErrorFailure(
        message: errorMessage,
      );
    }
  }

 }
