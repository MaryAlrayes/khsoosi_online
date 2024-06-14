import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/entities/signup_data_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/user_info_entity.dart';

import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';

class FetchUserDataUseCase {
  final AccountsRepo accountsRepo;
  FetchUserDataUseCase({
    required this.accountsRepo,
  });
  Future<Either<Failure, UserInfoEntity>> call({
    required String userId,
  }) async {
    final res = await accountsRepo.fetchUserInfo(userId: userId);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
