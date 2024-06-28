import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';

import '../entities/university_entity.dart';

abstract class UniversitiesRepo {
  Future<Either<Failure, List<UniversityEntity>>> getUniversities();

}
