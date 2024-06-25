import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/statistics/domain/entities/student_stat_entity.dart';
import 'package:khosousi_online/features/statistics/domain/entities/teacher_stat_entity.dart';

abstract class StatRepo {
  Future<Either<Failure,TeacherStatEntity>> getTeacherStat({required String userId});
 Future<Either<Failure,StudentStatEntity>> getStudentStat({required String userId});

}
