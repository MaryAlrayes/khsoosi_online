import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';

abstract class ChangePasswordRepo{
 Future<Either<Failure, Unit>> changePassword({
    required String userId,
    required String oldPassowrd,
    required String newPassword,
    required String confirmPassword,
  });
}
