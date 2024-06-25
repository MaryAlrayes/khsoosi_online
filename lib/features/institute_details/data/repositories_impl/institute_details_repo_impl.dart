// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/api_service/base_repo.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/institute_details/domain/entities/institute_details_entity.dart';
import 'package:khosousi_online/features/institute_details/domain/repositories/institute_details_repo.dart';

import '../data_sources/institute_details_data_provider.dart';

class InstituteDetailsRepoImpl implements InstituteDetailsRepo {
final InstituteDetailsDataProvider instituteDetailsDataProvider;
  InstituteDetailsRepoImpl({
    required this.instituteDetailsDataProvider,
  });

  @override
  Future<Either<Failure, InstituteDetailsEntity>> getInstituteDetails({required String id})async {
  final data = await BaseRepo.repoRequest(
      request: () async {
        return await instituteDetailsDataProvider.getInstituteDetails(id: id);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));

  }
}
