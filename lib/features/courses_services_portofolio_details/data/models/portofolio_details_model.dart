// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';

import '../../domain/entities/portofolio_details_entity.dart';

class PortofolioDetailsModel extends PortofolioDetailsEntity {
  PortofolioDetailsModel({
    required super.id,
    required super.title,
    required super.image,
    required super.description,
    required super.videoLink,
    required super.date,
    required super.likes,
    required super.dislikes,
    required super.categories,
    required super.teacherName,
    required super.teacherImage,
    required super.averageRate,
  });


  factory PortofolioDetailsModel.fromJson(Map<String, dynamic> map,) {
    Map<String, dynamic> info = map['portfolio_info'];
    List<dynamic> categories = map['portfolio_categories'];

    return PortofolioDetailsModel(
      id: info['Id'] ?? '',
      title: info['Title'] ?? '',
      date: info['creation_datetime'] ?? '',
      description: info['Description'] ?? '',
      videoLink: info['video_link'] ?? '',
      dislikes: int.tryParse(info['dislikes_count']) ?? 0,
      likes: int.tryParse(info['likes_count']) ?? 0,
      image:
          info['Image_link'] == null || (info['Image_link'] as String).isEmpty
              ? EndPointsManager.portofolioDefaultImageBaseUrl
              : EndPointsManager.portofolioImageBaseUrl + info['Image_link'],
      categories: (categories)
          .map(
            (e) => PortofolioDetailsCategoryModel.fromJson(e),
          )
          .toList(),
       averageRate:map['user_avg_rating']['average'] == null
          ? null
          : double.tryParse(map['user_avg_rating']['average']as String) ,
       teacherImage:map['user_info']['Image_path'] == null ||
              (map['user_info']['Image_path'] as String).isEmpty
          ? map['user_info']['Jender'] == '0'
              ? EndPointsManager.maleUserDefaultImageBaseUrl
              : EndPointsManager.femaleUserDefaultImageBaseUrl
          : EndPointsManager.userImageBaseUrl + map['user_info']['Image_path'] ,
       teacherName: map['user_info']['Name']??'',
    );
  }


}

class PortofolioDetailsCategoryModel extends PortofolioDetailsCategoryEntity {
  PortofolioDetailsCategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

   factory PortofolioDetailsCategoryModel.fromJson(Map<String, dynamic> map) {
    return PortofolioDetailsCategoryModel(
      id: map['Id'] ?? '',
      nameAr: map['Name_ar'] ?? '',
      nameEn: map['Name_en'] ?? '',
    );
  }
}
