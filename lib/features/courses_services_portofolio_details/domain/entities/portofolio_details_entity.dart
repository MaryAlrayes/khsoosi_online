// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PortofolioDetailsEntity extends Equatable {
  final String id;
  final String title;
  final String image;
  final String description;
  final String videoLink;
  final String date;
  final int likes;
  final int dislikes;
  final List<PortofolioDetailsCategoryEntity> categories;
  final String teacherName;
  final String teacherImage;
  final double? averageRate;
  PortofolioDetailsEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.videoLink,
    required this.date,
    required this.likes,
    required this.dislikes,
    required this.categories,
    required this.teacherName,
    required this.teacherImage,
    required this.averageRate,
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
        teacherName,
        teacherImage,
        averageRate,
      ];

 }

class PortofolioDetailsCategoryEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  PortofolioDetailsCategoryEntity({
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
