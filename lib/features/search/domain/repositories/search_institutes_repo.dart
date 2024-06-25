import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/search/domain/entities/course_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/institute_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_entity.dart';

abstract class SearchInstitutesRepo {
   Future<Either<Failure,List<InstituteEntity>>> getInstitutes({
    required int start,
    required String? countryId,
    required String? cityId,
    required String? categoryId,

  });
}
