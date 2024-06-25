// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/statistics/domain/entities/teacher_stat_entity.dart';

import '../entities/student_stat_entity.dart';
import '../repositories/state_repo.dart';

class FetchStudentStatUseCase {
  final StatRepo statRepo;
  FetchStudentStatUseCase({
    required this.statRepo,
  });
   Future<Either<Failure,StudentStatEntity>> call({required String userId})async{
     final res = await statRepo.getStudentStat(userId: userId);
    return res.fold((f) => Left(f), (r) => Right(r));

   }
}
