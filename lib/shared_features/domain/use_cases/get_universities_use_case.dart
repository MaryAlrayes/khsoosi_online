import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../features/location/domain/repositories/location_repo.dart';
import '../entities/university_entity.dart';
import '../repositories/university_repo.dart';

class GetUniversitiesUseCase{
   final UniversitiesRepo universitiesRepo;
  GetUniversitiesUseCase({
    required this.universitiesRepo,
  });

  Future<Either<Failure, List<UniversityEntity>>> call() async {
    final res = await universitiesRepo.getUniversities();
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
