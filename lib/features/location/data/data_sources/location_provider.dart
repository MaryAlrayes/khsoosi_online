import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/location/data/models/coords_model.dart';
import 'package:khosousi_online/shared_features/data/models/category_model.dart';
import 'package:khosousi_online/features/location/data/models/city_model.dart';
import 'package:khosousi_online/features/location/data/models/country_model.dart';

abstract class LocationProvider {
  Future<List<CountryModel>> getCountries();
  Future<List<CityModel>> getCities({required String country});
  Future<Unit> addLocation({required CoordsModel coordsModel ,required String userId});
}

class LocationProviderWithDio extends LocationProvider {
  final BaseApiService client;
  LocationProviderWithDio({
    required this.client,
  });

  @override
  Future<List<CountryModel>> getCountries() async {
    final res = await client.getRequest(
      url: EndPointsManager.getCountries,
    );
    List<CountryModel> data = [];

    res.forEach((element) {
      CountryModel countryModel = CountryModel.fromJson(element);

      data.add(countryModel);
    });
    return data;
  }

  @override
  Future<List<CityModel>> getCities({required String country}) async {
    final res = await client.multipartRequest(
        url: EndPointsManager.getCities, jsonBody: {'Country_name': country});
    List<CityModel> data = [];

    res.forEach((element) {
      CityModel cityModel = CityModel.fromJson(element);

      data.add(cityModel);
    });
    return data;
  }

  @override
  Future<Unit> addLocation({required CoordsModel coordsModel ,required String userId})async {
   final res = await client.multipartRequest(
      url: EndPointsManager.addLocation,
      jsonBody: coordsModel.toJson(userId),
    );
    if (res['status'] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['error messages'] as Map<String, dynamic>;
      List<String> keys = (errors).keys.toList();
      keys.forEach((e) {
        if (errors[e].isNotEmpty) {
          errorMessage += errors[e] + '\n';
        }
      });
      throw NetworkErrorFailure(
        message: errorMessage,
      );
    }
  }
}
