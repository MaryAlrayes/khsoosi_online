import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/entities/institute_contact_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/teacher_contact_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

class SubmitInstituteInfoUseCase {
  final AccountsRepo accountsRepo;

  SubmitInstituteInfoUseCase({
    required this.accountsRepo,
  });

  Future<Either<Failure, Unit>> call(
      {required InstituteContactEnitity instituteContactEnitity,
      required String userId}) async {
    final res = await accountsRepo.submitInstituteInfo(
      instituteContactEnitity: instituteContactEnitity,
      userId: userId,
    );
    return res.fold((f) => Left(f), (r) async {
      return Right(r);
    });
  }
}
