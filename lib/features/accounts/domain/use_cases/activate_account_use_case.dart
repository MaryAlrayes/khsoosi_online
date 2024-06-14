// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/entities/signup_data_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/user_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

class ActivateAccountUseCase {
  final AccountsRepo accountsRepo;
  final AuthRepo authRepo;
  ActivateAccountUseCase({
    required this.accountsRepo,
    required this.authRepo,
  });
  Future<Either<Failure, Unit>> call(
      {required String activationCode, required String userId}) async {
    final res = await accountsRepo.activateAccount(
        activationCode: activationCode, userId: userId);
    return res.fold((f) => Left(f), (r) async {
      await authRepo.updateActiveState();

      return Right(r);
    });
  }
}
