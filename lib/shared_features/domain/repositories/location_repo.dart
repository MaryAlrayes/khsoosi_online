
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/shared_features/domain/entities/city_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/coords_entity.dart';
import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';

abstract class LocationRepo {

  Future<Either<Failure, List<CountryEntity>>> getCountries();
  Future<Either<Failure, List<CityEntity>>> getCities({required String country});
 Future<Either<Failure, CoordsEntity>> getCoords();

}
