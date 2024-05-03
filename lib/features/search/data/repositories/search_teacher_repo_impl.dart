// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_repo.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/search/data/data%20providers/search_teachers_data_provider.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_entity.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_teachers_repo.dart';

class SearchTeachersRepoImp implements SearchTeachersRepo {
  final SearchTeacherDataProvider searchTeacherDataProvider;
  SearchTeachersRepoImp({
    required this.searchTeacherDataProvider,
  });
  @override
  Future<Either<Failure, List<TeacherEntity>>> getTeachers({
   required int start,
    required String? countryId,
    required String? cityId,
    required String? categoryId,
    required String? gender,
    required String? stage,
    required String? searchkeyword,
    required String teachMethod,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await searchTeacherDataProvider.getTeachers(
          start: start,
          countryId: countryId,
          cityId: cityId,
          categoryId: categoryId,
          gender: gender,
          stage: stage,
          teachMethod: teachMethod,
          searchkeyword:searchkeyword
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
