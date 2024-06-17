import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/entities/institute_extra_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

class SubmitInstituteExtraInfoUseCase {
  final AccountsRepo accountsRepo;
  final AuthRepo authRepo;
  SubmitInstituteExtraInfoUseCase({
    required this.accountsRepo,
    required this.authRepo,
  });

  Future<Either<Failure, Unit>> call({
    required InstituteExtraInfoEntity instituteExtraInfoEntity,
    required String userId,
  }) async {
    final res = await accountsRepo.submitExtraInfoInstituteInfo(
      instituteExtraInfoEntity: instituteExtraInfoEntity,
      userId: userId,
    );
    return res.fold((f) => Left(f), (r) async {
      await authRepo.updateHasFinishedInfoState();
      return Right(r);
    });
  }
}
