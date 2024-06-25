// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_repo.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/data/data%20providers/course_details_data_provider.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/data/data%20providers/service_details_data_provider.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_details_entity.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/repositories/course_details_repo.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/repositories/services_details_repo.dart';

class ServiceDetailsRepoImpl implements ServicesDetailsRepo {
  final ServiceDetailsDataProvider serviceDetailsDataProvider;
  ServiceDetailsRepoImpl({
    required this.serviceDetailsDataProvider,
  });


  @override
  Future<Either<Failure, CourseServiceDetailsEntity>> getServiceDetails({required String id})async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await serviceDetailsDataProvider.getServiceDetails(id: id);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));

  }
}
