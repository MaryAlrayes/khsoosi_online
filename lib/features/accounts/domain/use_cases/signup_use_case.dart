// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/entities/signup_data_entity.dart';

import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';

class SignupUseCase {
  final AccountsRepo accountsRepo;
  SignupUseCase({
    required this.accountsRepo,
  });
  Future<Either<Failure, Unit>> call({
    required SignupDataEntity signupDataEntity,
  }) async {
    final res = await accountsRepo.signup(
      signupDataEntity: signupDataEntity,
    );
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
