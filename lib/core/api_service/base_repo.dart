import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/locator/service_locator.dart';
import 'package:khosousi_online/core/network/check_internet.dart';

import '../errors/failures.dart';

class BaseRepo {
  static Future<Either<Failure, dynamic>> repoRequest(
      {required Function request}) async {
    NetworkInfo networkInfo = locator.get<NetworkInfo>();
    if (await networkInfo.isConnected) {
      try {
        final info = await request();
        return Right(info);
      } on Failure catch (f) {
        return Left(f);
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
