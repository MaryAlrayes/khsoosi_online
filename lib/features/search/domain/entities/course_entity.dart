// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable {
  final String id;
  final String title;
  final String countryAr;
  final String cityAr;
  final String imagePath;
  final bool isVipCourse;
  final String publisherUserId;
  final List<CourseCategoryEntity> categories;
  CourseEntity({
    required this.id,
    required this.title,
    required this.countryAr,
    required this.cityAr,
    required this.imagePath,
    required this.isVipCourse,
    required this.publisherUserId,
    required this.categories,
  });

  @override
  List<Object?> get props =>[
    id,
    title,
    countryAr,
    cityAr,
    imagePath,
    isVipCourse,
    publisherUserId,
    categories,
  ];




}

class CourseCategoryEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEng;
  CourseCategoryEntity({
    required this.id,
    required this.nameAr,
    required this.nameEng,
  });

  @override
  List<Object?> get props =>[
    id,
    nameAr,
    nameEng,
  ];



}
