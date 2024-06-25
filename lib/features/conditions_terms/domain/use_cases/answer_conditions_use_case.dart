// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/conditions_terms/domain/repositories/conditions_repo.dart';

class AnswerConditionsUseCase {
  final ConditionsRepo conditionsRepo;
  final AuthRepo authRepo;
  AnswerConditionsUseCase({
    required this.conditionsRepo,
    required this.authRepo,
  });
  Future<Either<Failure, Unit>> call(
      {required String userId, required bool Conditions}) async {
    final res = await conditionsRepo.answerConditions(
        userId: userId, Conditions: Conditions);
    return res.fold((f) => Left(f), (r)async {
      await authRepo.updateConditionsState(answer: Conditions);
      return Right(r);
    });
  }
}
