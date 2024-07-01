// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_repo.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/teacher_details/data/data%20provider/teacher_details_data_provider.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/repositories/teacher_details_repo.dart';

class TeacherDetailsRepoImpl extends TeacherDetailsRepo {
  final TeacherDetailsDataProvider teacherDetailsDataProvider;
  TeacherDetailsRepoImpl({
    required this.teacherDetailsDataProvider,
  });
  @override
  Future<Either<Failure, TeacherDetailsEntity>> getTeacherDetails(
      {required String id}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await teacherDetailsDataProvider.getTeacherDetails(id: id);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, String>> getTeacherPhones({
    required String teacherId,
    required TeacherPhones type,
    required String? requesterId,
    required String requesterFingerPrint,
    required bool isLoggedIn,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await teacherDetailsDataProvider.getTeacherPhones(
          teacherId: teacherId,
          type: type,
          requesterId: requesterId,
          requesterFingerPrint: requesterFingerPrint,
          isLoggedIn: isLoggedIn,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
