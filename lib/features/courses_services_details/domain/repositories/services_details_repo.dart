import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/courses_services_details/domain/entities/course_service_details_entity.dart';

abstract class ServicesDetailsRepo {
  Future<Either<Failure, CourseServiceDetailsEntity>> getServiceDetails({
    required String id,
  });
}
