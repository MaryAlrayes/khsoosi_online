import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_repo.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_portofolio/domain/repositories/teacher_portofolio_repo.dart';

import '../../domain/entities/teacher_portofolio_entity.dart';
import '../data_sources/teacher_portofolio_data_source.dart';

class TeacherPortofolioRepoImpl implements TeacherPortofolioRepo {
  final TeacherPortofoliosDataSource teacherPortofoliosDataSource;
  TeacherPortofolioRepoImpl({
    required this.teacherPortofoliosDataSource,
  });
  Future<Either<Failure, List<TeacherPortofolioEntity>>> getPortofolio(
      {required String userId}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await teacherPortofoliosDataSource.getPortofolio(userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
