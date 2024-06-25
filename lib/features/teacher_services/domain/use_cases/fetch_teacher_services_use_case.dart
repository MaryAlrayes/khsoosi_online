// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_courses/domain/entities/teacher_course_entity.dart';
import 'package:khosousi_online/features/teacher_services/domain/entities/teacher_service_entity.dart';
import 'package:khosousi_online/features/teacher_services/domain/repositories/teacher_service_repo.dart';


class FetchTeacherServicesUseCase {
  final TeacherServicesRepo teacherServicesRepo;
  FetchTeacherServicesUseCase({
    required this.teacherServicesRepo,
  });
   Future<Either<Failure, List<TeacherServiceEntity>>> call(
      {required String userId}) async {
    final res = await teacherServicesRepo.getServices(userId: userId);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
