// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/repositories/teacher_details_repo.dart';

class GetTeacherDetailsUseCase {
  final TeacherDetailsRepo teacherDetailsRepo;
  GetTeacherDetailsUseCase({
    required this.teacherDetailsRepo,
  });
  Future<Either<Failure, TeacherDetailsEntity>> call(
      {required String id}) async {
    final res = await teacherDetailsRepo.getTeacherDetails(id: id);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
