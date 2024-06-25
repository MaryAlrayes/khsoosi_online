// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/features/assistence/domain/entities/article_entity.dart';

import '../../../../core/api_service/base_repo.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/assistence_repo.dart';
import '../data_sources/assistence_data_source.dart';

class AssistenceRepoImpl implements AssistenceRepo {
  final AssistenceDataSource assistenceDataSource;
  AssistenceRepoImpl({
    required this.assistenceDataSource,
  });
  Future<Either<Failure, List<ArticleEntity>>> getArticles(
      {required int start}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await assistenceDataSource.getArticles(
          start: start,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
