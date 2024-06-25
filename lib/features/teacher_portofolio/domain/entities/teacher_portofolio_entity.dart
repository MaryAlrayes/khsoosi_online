// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  final String status;
  final bool isAccepted;
  final bool isRejected;
  final bool isPending;
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
    required this.status,
    required this.isAccepted,
    required this.isRejected,
    required this.isPending,
  });


  @override
  List<Object?> get props => [
    id,
    title,
    image,
    description,
    videoLink,
    date,
    likes,
    dislikes,
    categories,
    status,
    isAccepted,
    isRejected,
    isPending,
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
