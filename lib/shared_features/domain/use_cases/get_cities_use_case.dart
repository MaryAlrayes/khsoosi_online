// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/city_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';
import 'package:khosousi_online/shared_features/domain/repositories/categories_repo.dart';
import 'package:khosousi_online/shared_features/domain/repositories/location_repo.dart';

class GetCitiessUseCase {
  final LocationRepo countriesRepo;
  GetCitiessUseCase({
    required this.countriesRepo,
  });

  Future<Either<Failure, List<CityEntity>>> call(
      {required String country}) async {
    final res = await countriesRepo.getCities(country: country);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
