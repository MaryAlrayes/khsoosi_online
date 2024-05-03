// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_entity.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_teachers_repo.dart';

class SearchTeachersUseCase {
  final SearchTeachersRepo searchTeachersRepo;
  SearchTeachersUseCase({
    required this.searchTeachersRepo,
  });
  Future<Either<Failure, List<TeacherEntity>>> call(
      {required int start, required SearchFilterEntity filter}) async {
    final res = await searchTeachersRepo.getTeachers(
      start: start,
      countryId: filter.country == null ? null : filter.country!.id,
      cityId: filter.city == null ? null : filter.city!.id,
      categoryId: filter.speciality == null ? null : filter.speciality!.id,
      gender: filter.gender==null?'':filter.gender!.getValueForApi(),
      stage: filter.educationalLevel == null
          ? null
          : filter.educationalLevel!.getValueForApi(),
      teachMethod: filter.teachingMethod!.getValueForApi(),
      searchkeyword: filter.keyword
    );
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
