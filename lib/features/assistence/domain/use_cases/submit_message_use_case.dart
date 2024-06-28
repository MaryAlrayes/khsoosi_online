// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/features/assistence/data/repositories_impl/assistence_repo_impl.dart';
import 'package:khosousi_online/features/assistence/domain/entities/article_entity.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/assistence_repo.dart';

class SubmitMessageUseCase {
  final AssistenceRepo assistenceRepo;
  SubmitMessageUseCase({
    required this.assistenceRepo,
  });
   Future<Either<Failure,String>> call({required String id, required String message}
      ) async {
    final res = await assistenceRepo.sendMessage(id: id, message: message);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
