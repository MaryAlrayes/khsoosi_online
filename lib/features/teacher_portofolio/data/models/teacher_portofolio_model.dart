import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/teacher_portofolio/domain/entities/teacher_portofolio_entity.dart';

class TeacherPortofolioModel extends TeacherPortofolioEntity {
  TeacherPortofolioModel({
    required super.id,
    required super.title,
    required super.image,
    required super.description,
    required super.videoLink,
    required super.date,
    required super.likes,
    required super.dislikes,
    required super.categories,
    required super.status,
    required super.isAccepted,
    required super.isRejected,
    required super.isPending,
  });

  factory TeacherPortofolioModel.fromJson(Map<String, dynamic> map, int index) {
    Map<String, dynamic> info = map['portfolio_info $index'];
    List<dynamic> categories = map['portfolio_categories $index'];

    return TeacherPortofolioModel(
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
              (e) => TeacherPortofolioCategoryModel.fromJson(e),
            )
            .toList(),
        status: info['status'] ?? '0',
        isAccepted: info['status'] == '1',
        isRejected: info['status'] == '0',
        isPending: info['status'] == '-1');
  }
}

class TeacherPortofolioCategoryModel extends TeacherPortofolioCategoryEntity {
  TeacherPortofolioCategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });
  factory TeacherPortofolioCategoryModel.fromJson(Map<String, dynamic> map) {
    return TeacherPortofolioCategoryModel(
      id: map['Id'] ?? '',
      nameAr: map['Name_ar'] ?? '',
      nameEn: map['Name_en'] ?? '',
    );
  }
}
