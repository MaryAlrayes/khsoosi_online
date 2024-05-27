// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/service_entity.dart';

import '../repositories/search_services_repo.dart';

class SearchServicesUseCase {
  final SearchServicesRepo searchServicesRepo;
  SearchServicesUseCase({
    required this.searchServicesRepo,
  });
  Future<Either<Failure, List<ServiceEntity>>> call(
      {required int start, required SearchFilterEntity filter}) async {
    final res = await searchServicesRepo.getServices(
        start: start,
        countryId: filter.country == null ? null : filter.country!.id,
        cityId: filter.city == null ? null : filter.city!.id,
        searchkeyword: filter.keyword);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
