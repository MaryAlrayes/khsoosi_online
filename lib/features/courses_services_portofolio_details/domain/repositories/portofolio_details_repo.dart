import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_details_entity.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/portofolio_details_entity.dart';

abstract class PortofolioDetailsRepo {
  Future<Either<Failure, PortofolioDetailsEntity>> getPortofolioDetails({
    required String id,
  });
}
