import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

class UploadCertificatesUseCase {
  final AccountsRepo accountsRepo;

  UploadCertificatesUseCase({
    required this.accountsRepo,

  });
  Future<Either<Failure, Unit>> call({required List< File> image, required String userId}) async {
    final res = await accountsRepo.uploadCertificates(image: image, userId: userId);
    return res.fold(
      (f) => Left(f),
      (unit) async {
         return Right(unit);
      },
    );
  }
}
