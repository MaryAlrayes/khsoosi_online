// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/institute_details/domain/entities/institute_details_entity.dart';
import 'package:khosousi_online/features/institute_details/domain/repositories/institute_details_repo.dart';

class GetInstituteDetailsUseCase {
  final InstituteDetailsRepo instituteDetailsRepo;
  GetInstituteDetailsUseCase({
    required this.instituteDetailsRepo,
  });

Future<Either<Failure, InstituteDetailsEntity>> call(
      {required String id}) async {
    final res = await instituteDetailsRepo.getInstituteDetails(id: id);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
