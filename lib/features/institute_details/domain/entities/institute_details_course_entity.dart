// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class InstituteDetailsCourseEntity extends Equatable {
  final String id;
  final String title;
  final String image;
  final double rate;
  final String duration;
  final int lectureNumber;
  final List<InstituteDetailsCourseCategoryEntity> categories;
  InstituteDetailsCourseEntity({
    required this.id,
    required this.title,
     required this.image,
    required this.rate,
    required this.duration,
    required this.lectureNumber,
    required this.categories,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        rate,
        duration,
        lectureNumber,
        image,
        categories,
      ];

  @override
  bool get stringify => true;


}
class InstituteDetailsCourseCategoryEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  InstituteDetailsCourseCategoryEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });
  @override
  List<Object?> get props => [id,nameAr,nameEn];






}
