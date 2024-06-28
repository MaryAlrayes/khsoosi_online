// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/api_service/base_repo.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/shared_features/data/data%20provider/categories_provider.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';
import 'package:khosousi_online/shared_features/domain/repositories/categories_repo.dart';

import '../../domain/entities/university_entity.dart';
import '../../domain/repositories/university_repo.dart';
import '../data provider/universities_provider.dart';

class UniversitiesRepoImpl extends UniversitiesRepo {
  final UniversitiesDataSource universitiesDataSource;
  UniversitiesRepoImpl({
    required this.universitiesDataSource,
  });
  @override
   Future<Either<Failure, List<UniversityEntity>>> getUniversities() async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await universitiesDataSource.fetchUniversities();
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

}
