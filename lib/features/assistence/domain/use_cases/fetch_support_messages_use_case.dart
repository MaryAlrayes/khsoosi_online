// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/features/assistence/data/repositories_impl/assistence_repo_impl.dart';
import 'package:khosousi_online/features/assistence/domain/entities/article_entity.dart';
import 'package:khosousi_online/features/assistence/domain/entities/support_message_entity.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/assistence_repo.dart';

class FetchSupportMessagesUseCase {
  final AssistenceRepo assistenceRepo;
  FetchSupportMessagesUseCase({
    required this.assistenceRepo,
  });
  Future<Either<Failure, List<SupportMessageEntity>>> call(
      {required String id, required int start}) async {
    final res = await assistenceRepo.getSupportMessages(id: id, start: start);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
