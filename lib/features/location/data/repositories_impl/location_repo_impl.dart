// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/api_service/base_repo.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/utils/services/location_service.dart';
import 'package:khosousi_online/shared_features/data/data%20provider/categories_provider.dart';
import 'package:khosousi_online/features/location/data/data_sources/location_provider.dart';
import 'package:khosousi_online/features/location/data/models/coords_model.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/city_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/coords_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/country_entity.dart';
import 'package:khosousi_online/shared_features/domain/repositories/categories_repo.dart';
import 'package:khosousi_online/features/location/domain/repositories/location_repo.dart';

class LocationRepoImpl implements LocationRepo {
  final LocationProvider locationProvider;
  LocationRepoImpl({
    required this.locationProvider,
  });

  @override
  Future<Either<Failure, List<CountryEntity>>> getCountries() async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await locationProvider.getCountries();
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<CityEntity>>> getCities(
      {required String country}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await locationProvider.getCities(country: country);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, CoordsEntity>> getCoords() async {
    try {
      GeoLoc? coords = await LocationService.getLocationCoords();

      if (coords == null) {
        return Left(
          NetworkErrorFailure(
            message: 'Error Fetching Coordinates',
            responseCode: -1,
          ),
        );
      }
      return Right(
        CoordsModel(
          lat: coords.lat,
          lng: coords.lng,
        ),
      );
    } on Exception {
      return Left(
        NetworkErrorFailure(
          message: 'Error Fetching Coordinates',
          responseCode: -1,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> addLocation(
      {required CoordsEntity coords, required String userId}) async {
    CoordsModel coordsModel = CoordsModel(lat: coords.lat, lng: coords.lng);
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await locationProvider.addLocation(
          coordsModel: coordsModel,
          userId: userId,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
