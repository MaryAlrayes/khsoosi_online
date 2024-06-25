// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/statistics/domain/entities/teacher_stat_entity.dart';

import '../repositories/state_repo.dart';

class FetchTeacherStatUseCase {
  final StatRepo teacherStatRepo;
  FetchTeacherStatUseCase({
    required this.teacherStatRepo,
  });
   Future<Either<Failure,TeacherStatEntity>> call({required String userId})async{
     final res = await teacherStatRepo.getTeacherStat(userId: userId);
    return res.fold((f) => Left(f), (r) => Right(r));

   }
}
