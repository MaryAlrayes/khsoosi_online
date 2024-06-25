import 'package:dartz/dartz.dart';
import 'package:khosousi_online/features/assistence/domain/entities/article_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class AssistenceRepo{
 Future<Either<Failure,List<ArticleEntity>>> getArticles({required int start});
}
