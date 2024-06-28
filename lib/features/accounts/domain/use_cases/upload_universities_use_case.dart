import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

import '../../../../shared_features/domain/entities/university_entity.dart';

class UploadUniversitiesUseCase {
  final AccountsRepo accountsRepo;

  UploadUniversitiesUseCase({
    required this.accountsRepo,

  });
   Future<Either<Failure, Unit>> call({required List<UniversityEntity> universities, required String courses, required String userId}) async {
    final res = await accountsRepo.uploadUniversities(
            universities: universities, courses: courses, userId: userId);
    return res.fold(
      (f) => Left(f),
      (unit) async {
         return Right(unit);
      },
    );
  }
}
