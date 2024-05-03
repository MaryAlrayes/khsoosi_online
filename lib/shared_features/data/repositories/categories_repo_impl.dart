// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/api_service/base_repo.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/shared_features/data/data%20provider/categories_provider.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';
import 'package:khosousi_online/shared_features/domain/repositories/categories_repo.dart';

class CategoriesRepoImpl extends CategoriesRepo {
  final CategoriesProvider categoriesProvider;
  CategoriesRepoImpl({
    required this.categoriesProvider,
  });
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await categoriesProvider.getCategories();
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<CountryEntity>>> getCountries()async {
  final data = await BaseRepo.repoRequest(
      request: () async {
        return await categoriesProvider.getCategories();
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
