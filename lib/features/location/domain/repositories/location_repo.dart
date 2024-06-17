import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/location/domain/entities/city_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/coords_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';

abstract class LocationRepo {
  Future<Either<Failure, List<CountryEntity>>> getCountries();
  Future<Either<Failure, List<CityEntity>>> getCities(
      {required String country});
  Future<Either<Failure, CoordsEntity>> getCoords();
  Future<Either<Failure, Unit>> addLocation(
      {required CoordsEntity coords, required String userId});
}
