// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class TeacherPortofolioEntity extends Equatable {
  final String id;
  final String title;
  final String image;
  final String description;
  final String videoLink;
  final String date;
  final int likes;
  final int dislikes;
  final List<TeacherPortofolioCategoryEntity> categories;
  TeacherPortofolioEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.videoLink,
    required this.date,
    required this.likes,
    required this.dislikes,
    required this.categories,
  });
  @override
  List<Object?> get props => [
        id,
        title,
        image,
        categories,
        description,
        videoLink,
        date,
        likes,
        dislikes,
      ];
}

class TeacherPortofolioCategoryEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  TeacherPortofolioCategoryEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });
  @override
  List<Object?> get props => [
        id,
        nameAr,
        nameEn,
      ];
}
