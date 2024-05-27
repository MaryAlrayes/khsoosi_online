// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_repo.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/search/data/data%20providers/search_courses_data_provider.dart';
import 'package:khosousi_online/features/search/data/data%20providers/search_services_data_provider.dart';
import 'package:khosousi_online/features/search/data/data%20providers/search_teachers_data_provider.dart';
import 'package:khosousi_online/features/search/domain/entities/course_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/service_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_entity.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_courses_repo.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_services_repo.dart';
import 'package:khosousi_online/features/search/domain/repositories/search_teachers_repo.dart';

class SearchServicesRepoImp implements SearchServicesRepo {
  final SearchServicesDataProvider searchServicesDataProvider;
  SearchServicesRepoImp({
    required this.searchServicesDataProvider,
  });

  @override
  Future<Either<Failure, List<ServiceEntity>>> getServices({
    required int start,
    required String? countryId,
    required String? cityId,
    required String? searchkeyword,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await searchServicesDataProvider.getServices(
            start: start,
            countryId: countryId,
            cityId: cityId,
            searchkeyword: searchkeyword);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
