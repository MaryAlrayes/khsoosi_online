// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_repo.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_services/data/data_sources/teacher_service_data_source.dart';
import 'package:khosousi_online/features/teacher_services/domain/entities/teacher_service_entity.dart';
import 'package:khosousi_online/features/teacher_services/domain/repositories/teacher_service_repo.dart';

class TeacherServicesRepoImpl implements TeacherServicesRepo {
  final TeacherServicesDataSource teacherServicesDataSource;
  TeacherServicesRepoImpl({
    required this.teacherServicesDataSource,
  });

  Future<Either<Failure, List<TeacherServiceEntity>>> getServices({required String userId}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await teacherServicesDataSource.getServices(userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
