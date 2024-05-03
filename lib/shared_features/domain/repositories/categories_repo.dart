import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();

}
