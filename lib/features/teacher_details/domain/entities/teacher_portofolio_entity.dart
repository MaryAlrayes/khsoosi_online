
import 'package:equatable/equatable.dart';

class TeacherPortofolioEntity extends Equatable {
  final String id;
  final String title;
  final String image;
  final List<TeacherPortofolioCategoryEntity> categories;
  TeacherPortofolioEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.categories,
  });
  @override
  List<Object?> get props => [id,title,image,categories];




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
   nameEn,];



}
