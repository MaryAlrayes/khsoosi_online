import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/search/domain/entities/course_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_entity.dart';

abstract class SearchTeachersRepo {
  Future<Either<Failure, List<TeacherEntity>>> getTeachers({
    required int start,
    required String? countryId,
    required String? cityId,
    required String? categoryId,
    required String? gender,
    required String? stage,
    required String? searchkeyword,
    required String teachMethod,
    required double? lat,
    required double? lng,
  });
}
