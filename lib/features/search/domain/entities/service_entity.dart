// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
   final String id;
  final String title;
  final String countryAr;
  final String cityAr;
  final String imagePath;
  final bool isVipService;
  final String publisherName;
  final List<ServiceCategoryEntity> categories;
  ServiceEntity({
    required this.id,
    required this.title,
    required this.countryAr,
    required this.cityAr,
    required this.imagePath,
    required this.isVipService,
    required this.publisherName,
    required this.categories,
  });

  @override
  List<Object?> get props =>[
    id,
    title,
    countryAr,
    cityAr,
    imagePath,
    isVipService,
    publisherName,
    categories,
  ];




 }

class ServiceCategoryEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEng;
  ServiceCategoryEntity({
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
