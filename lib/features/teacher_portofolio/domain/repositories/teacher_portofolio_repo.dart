import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_courses/domain/entities/teacher_course_entity.dart';
import 'package:khosousi_online/features/teacher_services/domain/entities/teacher_service_entity.dart';

import '../entities/teacher_portofolio_entity.dart';

abstract class TeacherPortofolioRepo {
  Future<Either<Failure, List<TeacherPortofolioEntity>>> getPortofolio({required String userId});
}
