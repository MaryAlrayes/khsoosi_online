// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/entities/login_data_entity.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

import '../repositories/accounts_repo.dart';

class LoginUseCase {
  final AccountsRepo accountsRepo;
  final AuthRepo authRepo;
  LoginUseCase({
    required this.accountsRepo,
    required this.authRepo,
  });
  Future<Either<Failure, Unit>> call({
    required LoginDataEntity loginDataEntity,
  }) async {
    final res = await accountsRepo.login(loginDataEntity: loginDataEntity);
    return res.fold(
      (f) => Left(f),
      (userData) async {
       await authRepo.saveUserInfo(userData);
       return Right(unit);
      },
    );
  }
}
