// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/core/utils/services/location_service.dart';
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
        categoryId: filter.speciality == null ? null : filter.speciality!.id,
        gender: filter.gender == null ? '' : filter.gender!.getValueForApi(),
        stage: filter.educationalLevel == null
            ? null
            : filter.educationalLevel!.getValueForApi(),
        teachMethod: filter.teachingMethod!.getValueForApi(),
        searchkeyword: filter.keyword,
        countryId: filter.locationType == LocationType.chooseCountey
            ? filter.country != null
                ? filter.country!.id
                : null
            : null,
        cityId: filter.locationType == LocationType.chooseCountey
            ? filter.city != null
                ? filter.city!.id
                : null
            : null,
        lat: filter.locationType == LocationType.nearestTeacher
            ? filter.lat
            : null,
        lng: filter.locationType == LocationType.nearestTeacher
            ? filter.lng
            : null);
    return res.fold((f) => Left(f), (data) {
      List<TeacherEntity> updatedData = [];
      data.forEach(
        (element) {
          //calculate distance between teacher and user
          if (filter.locationType == LocationType.nearestTeacher) {
            double? userLat = filter.lat;
            double? userLng = filter.lng;
            double? teacherLat = element.lat;
            double? teacherLng = element.lng;
            if (userLat != null &&
                userLng != null &&
                teacherLat != null &&
                teacherLng != null) {
              double distance = LocationService.calculateDistanceInKilo(
                lat1: userLat,
                lat2: teacherLat,
                lng1: userLng,
                lng2: teacherLng,
              );
              print('distance $distance');
              updatedData.add(element.copyWith(distance: distance));
            }else{
                updatedData.add(element);
            }
          }else{
               updatedData.add(element);
          }
        },
      );
      return Right(updatedData);
    });
  }
}
