// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_courses/domain/entities/teacher_course_entity.dart';

import '../entities/teacher_balance_entity.dart';
import '../repositories/teacher_balance_repo.dart';

class FetchBalanceUseCase {
  final TeacherBalanceRepo teacherBalanceRepo;
  FetchBalanceUseCase({
    required this.teacherBalanceRepo,
  });
  Future<Either<Failure, TeacherBalanceEntity>> call(
      {required String userId}) async {
    final res = await teacherBalanceRepo.getBalance(userId: userId);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
