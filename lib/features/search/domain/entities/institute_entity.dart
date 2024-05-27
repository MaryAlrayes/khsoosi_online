// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class InstituteEntity extends Equatable {
  final String id;
  final String title;
  final String countryAr;
  final String cityAr;
  final String imagePath;
  final List<InstituteCategoryEntity> categories;
  InstituteEntity({
    required this.id,
    required this.title,
    required this.countryAr,
    required this.cityAr,
    required this.imagePath,
    required this.categories,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    countryAr,
    cityAr,
    imagePath,
    categories,
  ];

}

class InstituteCategoryEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEng;
  InstituteCategoryEntity({
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
