import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_details_entity.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/repositories/course_details_repo.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';

import '../entities/portofolio_details_entity.dart';
import '../repositories/portofolio_details_repo.dart';

class PortofolioDetailsUseCase {
  final PortofolioDetailsRepo portofolioDetailsRepo;
  PortofolioDetailsUseCase({
    required this.portofolioDetailsRepo,
  });
  Future<Either<Failure, PortofolioDetailsEntity>> call(
      {required String id}) async {
    final res = await portofolioDetailsRepo.getPortofolioDetails(id: id);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
