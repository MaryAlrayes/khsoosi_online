import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_balance/domain/entities/teacher_balance_entity.dart';
import 'package:khosousi_online/features/teacher_courses/domain/entities/teacher_course_entity.dart';
import 'package:khosousi_online/features/teacher_services/domain/entities/teacher_service_entity.dart';

import '../../../../core/api_service/base_repo.dart';
import '../../domain/repositories/teacher_balance_repo.dart';
import '../data_sources/teacher_balance_data_source.dart';

 class TeacherBalanceRepoImp implements TeacherBalanceRepo {
  final TeacherBalanceDataSource teacherBalanceDataSource;
  TeacherBalanceRepoImp({
    required this.teacherBalanceDataSource,
  });

  Future<Either<Failure, TeacherBalanceEntity>> getBalance(
      {required String userId}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await teacherBalanceDataSource.getBalance(userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
 }
