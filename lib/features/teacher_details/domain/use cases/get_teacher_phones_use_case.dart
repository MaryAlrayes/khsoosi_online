// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/repositories/teacher_details_repo.dart';

import '../../../../core/utils/enums/enums.dart';

class GetTeacherPhonesUseCase {
  final TeacherDetailsRepo teacherDetailsRepo;
  GetTeacherPhonesUseCase({
    required this.teacherDetailsRepo,
  });
  Future<Either<Failure,String>> call(
      {required String teacherId,
      required TeacherPhones type,
      required String? requesterId,
      required String requesterFingerPrint,
      required bool isLoggedIn}) async {
    final res = await teacherDetailsRepo.getTeacherPhones(teacherId: teacherId, type: type, requesterId: requesterId, requesterFingerPrint: requesterFingerPrint, isLoggedIn: isLoggedIn);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
