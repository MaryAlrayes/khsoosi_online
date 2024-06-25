// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_repo.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/conditions_terms/data/data_sources/conditions_data_source.dart';
import 'package:khosousi_online/features/conditions_terms/domain/repositories/conditions_repo.dart';

class ConditionsRepoImpl implements ConditionsRepo {
  final ConditionsDataProvider conditionsDataProvider;
  ConditionsRepoImpl({
    required this.conditionsDataProvider,
  });
  @override
  Future<Either<Failure, Unit>> answerConditions({required String userId, required bool Conditions})async {
     final data = await BaseRepo.repoRequest(
      request: () async {
        return await conditionsDataProvider.answerConditions(userId: userId, Conditions: Conditions);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

}
