// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:khosousi_online/features/search/domain/entities/teacher_category_entity.dart';

class TeacherEntity extends Equatable {
  final String id;
  final String name;
  final String imagePath;
  final bool isVipAccount;
  final bool isSpecial;
  final String countryEn;
  final String countryAr;
  final String cityEn;
  final String cityAr;
  final String address;
  final bool teachMethodInternet;
  final bool teachMethodStudentHouse;
  final bool teachMethodTeacherHouse;
  final bool hasBioVideo;
  final bool teachMethodOfflineByRoot;
  final double? average;
  final String countryCode;
  final List<TeacherCategoryEntity> teacherSpecialityEntity;

  TeacherEntity({
   required  this.id,
    required this.name,
    required this.imagePath,
    required this.isVipAccount,
    required this.isSpecial,
    required this.countryEn,
    required this.countryAr,
    required this.cityEn,
    required this.cityAr,
    required this.address,
    required this.teachMethodInternet,
    required this.teachMethodStudentHouse,
    required this.teachMethodTeacherHouse,
    required this.hasBioVideo,
    required this.teachMethodOfflineByRoot,
    this.average,
   required  this.countryCode,
    required this.teacherSpecialityEntity,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imagePath,
        isVipAccount,
        isSpecial,
        address,
        teachMethodInternet,
        teachMethodStudentHouse,
        teachMethodTeacherHouse,
        hasBioVideo,
        teachMethodOfflineByRoot,
        average,
        countryEn,
        countryAr,
        cityEn,
        cityAr,
        teacherSpecialityEntity,
        countryCode
      ];
}
