// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/features/assistence/data/repositories_impl/assistence_repo_impl.dart';
import 'package:khosousi_online/features/assistence/domain/entities/article_entity.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/assistence_repo.dart';

class FetchFaqUseCase {
  final AssistenceRepo assistenceRepo;
  FetchFaqUseCase({
    required this.assistenceRepo,
  });
  Future<Either<Failure, List<ArticleEntity>>> call(
      ) async {
    final res = await assistenceRepo.getArticles(

    );
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
