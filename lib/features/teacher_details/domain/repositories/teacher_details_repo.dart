import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';

import '../../../../core/utils/enums/enums.dart';

abstract class TeacherDetailsRepo{
  Future<Either<Failure,TeacherDetailsEntity>> getTeacherDetails({required String id});
  Future<Either<Failure,String>> getTeacherPhones(
      {required String teacherId,
      required TeacherPhones type,
      required String? requesterId,
      required String requesterFingerPrint,
      required bool isLoggedIn});
}
