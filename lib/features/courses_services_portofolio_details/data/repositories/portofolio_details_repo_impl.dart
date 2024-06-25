// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_details_entity.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/portofolio_details_entity.dart';

import '../../../../core/api_service/base_repo.dart';
import '../../domain/repositories/portofolio_details_repo.dart';
import '../data providers/portofolio_details_data_provider.dart';

class PortofolioDetailsRepoImpl implements PortofolioDetailsRepo {
  final PortofolioDetailsDataProvider portofolioDetailsDataProvider;
  PortofolioDetailsRepoImpl({
    required this.portofolioDetailsDataProvider,
  });

  Future<Either<Failure, PortofolioDetailsEntity>> getPortofolioDetails({
    required String id,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await portofolioDetailsDataProvider.getPortofolioDetails(id: id);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
