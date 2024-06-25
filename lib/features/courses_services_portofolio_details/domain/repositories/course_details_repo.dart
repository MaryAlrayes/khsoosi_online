import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_details_entity.dart';

abstract class CourseDetailsRepo {
  Future<Either<Failure, CourseServiceDetailsEntity>> getCourseDetails({
    required String id,
  });
}
