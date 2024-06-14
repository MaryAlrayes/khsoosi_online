import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/entities/signup_data_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/user_info_entity.dart';

import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';
import 'package:khosousi_online/features/edit_password/domain/repositories/change_password_repo.dart';

class ChangePasswordUseCase {
  final ChangePasswordRepo changePasswordRepo;
  ChangePasswordUseCase({
    required this.changePasswordRepo,
  });
  Future<Either<Failure, Unit>> call({
    required String userId,
    required String oldPassowrd,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final res = await changePasswordRepo.changePassword(
      userId: userId,
      oldPassowrd: oldPassowrd,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
