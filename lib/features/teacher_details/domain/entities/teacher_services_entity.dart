// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TeacherServicesEntity extends Equatable {
    final String id;
  final String title;
  final bool isVipService;
  final String image;
  final String countryAr;
  final String countryEn;
  final String cityAr;
   final String cityEn;
   final List<TeacherServicesCategoryEntity> categories;
  TeacherServicesEntity({
    required this.id,
    required this.title,
    required this.isVipService,
    required this.image,
    required this.countryAr,
    required this.countryEn,
    required this.cityAr,
    required this.cityEn,
    required this.categories,
  });

  @override
  List<Object?> get props =>[
    id,
    title,
    isVipService,
    image,
    countryAr,
    countryEn,
    cityAr,
    cityEn,
    categories
  ];
}

class TeacherServicesCategoryEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  TeacherServicesCategoryEntity({
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
