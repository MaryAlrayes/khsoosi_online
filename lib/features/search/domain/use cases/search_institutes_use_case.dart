// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/search/domain/entities/course_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/institute_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_entity.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_courses_repo.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_institutes_repo.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_teachers_repo.dart';

class SearchInstitutesUseCase {
  final SearchInstitutesRepo searchInstitutesRepo;
  SearchInstitutesUseCase({
    required this.searchInstitutesRepo,
  });
   Future<Either<Failure,List<InstituteEntity>>> call({
    required int start, required SearchFilterEntity filter}
  ) async {

    final res = await searchInstitutesRepo.getInstitutes(
      start: start,
      countryId: filter.country == null ? null : filter.country!.id,
      cityId: filter.city == null ? null : filter.city!.id,
      categoryId: filter.speciality == null ? null : filter.speciality!.id,
     );
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
