import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/entities/teacher_extra_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

class SubmitTeacherExtraInfoUseCase {
  final AccountsRepo accountsRepo;
  final AuthRepo authRepo;
  SubmitTeacherExtraInfoUseCase({
    required this.accountsRepo,
    required this.authRepo,
  });

  Future<Either<Failure, Unit>> call(
      {required TeacherExtraInfoEntity teacherExtraInfoEntity,
      required String userId}) async {
    final res = await accountsRepo.submitExtraTeacherInfo(
      teacherExtraInfo: teacherExtraInfoEntity,
      userId: userId,
    );
    return res.fold((f) => Left(f), (r) async {
      await authRepo.updateHasFinishedInfoState();
      return Right(r);
    });
  }
}
