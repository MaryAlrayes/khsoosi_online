
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/statistics/domain/entities/student_stat_entity.dart';
import 'package:khosousi_online/features/statistics/domain/entities/teacher_stat_entity.dart';

import '../../../../core/api_service/base_repo.dart';
import '../../domain/repositories/state_repo.dart';
import '../data_sources/teacher_stat_data_source.dart';

 class StatRepoImp implements StatRepo {
  final TeacherStatDataSource teacherStatDataSource;
  StatRepoImp({
    required this.teacherStatDataSource,
  });
  Future<Either<Failure,TeacherStatEntity>> getTeacherStat({required String userId})async{
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await teacherStatDataSource.getTeacherStat(userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
 Future<Either<Failure,StudentStatEntity>> getStudentStat({required String userId})async{
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await teacherStatDataSource.getStudentStat(userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
