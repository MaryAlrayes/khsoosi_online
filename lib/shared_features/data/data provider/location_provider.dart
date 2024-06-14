import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/shared_features/data/models/category_model.dart';
import 'package:khosousi_online/shared_features/data/models/city_model.dart';
import 'package:khosousi_online/shared_features/data/models/country_model.dart';

abstract class CountriesProvider {
  Future<List<CountryModel>> getCountries();
  Future<List<CityModel>> getCities({required String country});
}

class CountriesProviderWithDio extends CountriesProvider {
  final BaseApiService client;
  CountriesProviderWithDio({
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
}
