import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_portofolio_entity.dart';

class TeacherPortofolioModel extends TeacherPortofolioEntity {
  TeacherPortofolioModel(
      {required super.id,
      required super.title,
      required super.image,
      required super.categories});

  factory TeacherPortofolioModel.fromJson(Map<String, dynamic> map, int index) {
    dynamic info = map['portfolio_info $index'];
    dynamic categories = map['portfolio_categories $index'];
    return TeacherPortofolioModel(
      id: info['Id'] ??'',
      title: info['Title'] ??'',
      image: info['Image_link'] == null || (info['Image_link'] as String).isEmpty
          ? EndPointsManager.portofolioDefaultImageBaseUrl
          : EndPointsManager.portofolioImageBaseUrl + info['Image_link'],
          categories:
            (categories as List<dynamic>)
                .map(
                  (e) => TeacherPortofolioCategoryModel.fromJson(e),
                )
                .toList(),

    );
  }
}

class TeacherPortofolioCategoryModel extends TeacherPortofolioCategoryEntity {
  TeacherPortofolioCategoryModel(
      {required super.id, required super.nameAr, required super.nameEn});

  factory TeacherPortofolioCategoryModel.fromJson(Map<String, dynamic> map) {
    return TeacherPortofolioCategoryModel(
      id: map['Id'] ?? '',
      nameAr: map['Name_ar'] ?? '',
      nameEn: map['Name_en'] ?? '',
    );
  }
}
