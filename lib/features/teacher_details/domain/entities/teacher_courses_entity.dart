// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class TeacherCoursesEntity extends Equatable {
  final String id;
  final String title;
  final bool isVipCourse;
  final String image;
  final bool presense;
  final bool online;
  final List<TeacherCourseCategoryEntity> categories;
  TeacherCoursesEntity({
    required this.id,
    required this.title,
    required this.isVipCourse,
    required this.image,
    required this.presense,
    required this.online,
    required this.categories,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    isVipCourse,
    image,
    presense,
    online,
    categories
  ];



 }
class TeacherCourseCategoryEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  TeacherCourseCategoryEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });
  @override
  List<Object?> get props => [
   id,
   nameAr,
   nameEn,];

}
