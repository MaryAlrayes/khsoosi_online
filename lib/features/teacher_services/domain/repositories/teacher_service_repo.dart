import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_courses/domain/entities/teacher_course_entity.dart';
import 'package:khosousi_online/features/teacher_services/domain/entities/teacher_service_entity.dart';

abstract class TeacherServicesRepo {
  Future<Either<Failure, List<TeacherServiceEntity>>> getServices({required String userId});
}
