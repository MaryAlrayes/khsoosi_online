import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';

abstract class ConditionsRepo {
  Future<Either<Failure,Unit>> answerConditions({required String userId,required bool Conditions});
}
