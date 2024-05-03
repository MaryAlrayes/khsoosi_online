// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/shared_features/domain/repositories/categories_repo.dart';

class GetCategoriesUseCase {
  final CategoriesRepo categoriesRepo;
  GetCategoriesUseCase({
    required this.categoriesRepo,
  });
  Future<Either<Failure, List<CategoryEntity>>> call() async {
    final res = await categoriesRepo.getCategories();
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
