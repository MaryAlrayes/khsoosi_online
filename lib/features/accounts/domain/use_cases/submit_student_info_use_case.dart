// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/entities/student_contact_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

class SubmitStudentInfoUseCase {
  final AccountsRepo accountsRepo;
  final AuthRepo authRepo;
  SubmitStudentInfoUseCase({
    required this.accountsRepo,
    required this.authRepo,
  });

  Future<Either<Failure, Unit>> call(
      {required StudentContactInfoEntity studentInfoEntity,
      required String userId}) async {
    final res = await accountsRepo.submitStudentInfo(
      studentInfoEntity: studentInfoEntity,
      userId: userId,
    );
    return res.fold((f) => Left(f), (r) async {
      await authRepo.updateHasFinishedInfoState();
      return Right(r);
    });
  }
}
