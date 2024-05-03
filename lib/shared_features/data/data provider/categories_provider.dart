import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/shared_features/data/models/category_model.dart';

abstract class CategoriesProvider {
  Future<List<CategoryModel>> getCategories();
}

class CategoriesProviderWithDio extends CategoriesProvider {
  final BaseApiService client;
  CategoriesProviderWithDio({
    required this.client,
  });

  @override
  Future<List<CategoryModel>> getCategories() async {
    final res = await client.getRequest(
      url: EndPointsManager.getCategories,
    );
    List<CategoryModel> data = [];

    res.forEach((element) {
      CategoryModel categoryModel = CategoryModel.fromJson(element);

      data.add(categoryModel);
    });
    return data;
  }
}
