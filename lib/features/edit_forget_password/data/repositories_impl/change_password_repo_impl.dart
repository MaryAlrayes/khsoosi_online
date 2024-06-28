// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_repo.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/edit_forget_password/data/data_sources/edit_password_data_source.dart';
import 'package:khosousi_online/features/edit_forget_password/domain/repositories/change_password_repo.dart';

class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ChangePasswordProvider changePasswordProvider;
  ChangePasswordRepoImpl({
    required this.changePasswordProvider,
  });

  @override
  Future<Either<Failure, Unit>> changePassword({
    required String userId,
    required String oldPassowrd,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await changePasswordProvider.changePassword(
          userId: userId,
          oldPassowrd: oldPassowrd,
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
