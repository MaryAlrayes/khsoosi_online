import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/search/domain/entities/service_entity.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel(
      {required super.id,
      required super.title,
      required super.countryAr,
      required super.cityAr,
      required super.imagePath,
      required super.isVipService,
      required super.publisherName,
      required super.categories});


  factory ServiceModel.fromJson(Map<String, dynamic> map,int index) {
     Map<String, dynamic> service = map['service_info $index'];
    List<dynamic> categories = map['service_categories $index'];
    return ServiceModel(
      id: service['Id'] ??'',
      title: service['Title'] ??'',
      countryAr: service['Country_Name_ar'] ??'',
      cityAr: service['City_Name_ar'] ??'',
      imagePath:  service['Image_path'] == null || (service['Image_path'] as String).isEmpty
          ? EndPointsManager.servicesDefaultImageBaseUrl
          : EndPointsManager.servicesImageBaseUrl + service['Image_path'],
      isVipService: service['Is_vip_service'] =='1',
      publisherName: service['Publisher_Name'] ??'',
      categories:  List.generate(
          categories.length,
          (index) => ServiceCategoryModel.fromJson(
            categories[index],
          ),
        ),
    );
  }


}

class ServiceCategoryModel extends ServiceCategoryEntity {
  ServiceCategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEng,
  });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> map) {
    return ServiceCategoryModel(
      id: map['Id'] ??'',
      nameAr: map['Name_ar'] ??'',
      nameEng: map['Name_en'] ??'',
    );
  }
}
