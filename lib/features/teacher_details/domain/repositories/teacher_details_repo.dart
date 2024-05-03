import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';

abstract class TeacherDetailsRepo{
  Future<Either<Failure,TeacherDetailsEntity>> getTeacherDetails({required String id});

}
