import 'package:dartz/dartz.dart';
import 'package:khosousi_online/features/assistence/domain/entities/article_entity.dart';

import '../../../../core/errors/failures.dart';
import '../entities/support_message_entity.dart';

abstract class AssistenceRepo{
 Future<Either<Failure,List<ArticleEntity>>> getArticles();
  Future<Either<Failure,List<SupportMessageEntity>>> getSupportMessages({required String id,required int start});
 Future<Either<Failure,String>> sendMessage({required String id, required String message});
}
