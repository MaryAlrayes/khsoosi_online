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
  final double? lat;
  final double? lng;
  final double? distance;
  final List<TeacherCategoryEntity> teacherSpecialityEntity;

  TeacherEntity({
    required this.id,
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
    required this.countryCode,
    this.lat,
    this.lng,
     this.distance,
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
        countryCode,
        lat,
        lng,
        distance
      ];

  TeacherEntity copyWith({
    String? id,
    String? name,
    String? imagePath,
    bool? isVipAccount,
    bool? isSpecial,
    String? countryEn,
    String? countryAr,
    String? cityEn,
    String? cityAr,
    String? address,
    bool? teachMethodInternet,
    bool? teachMethodStudentHouse,
    bool? teachMethodTeacherHouse,
    bool? hasBioVideo,
    bool? teachMethodOfflineByRoot,
    double? average,
    String? countryCode,
    double? lat,
    double? lng,
    double? distance,
    List<TeacherCategoryEntity>? teacherSpecialityEntity,
  }) {
    return TeacherEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      isVipAccount: isVipAccount ?? this.isVipAccount,
      isSpecial: isSpecial ?? this.isSpecial,
      countryEn: countryEn ?? this.countryEn,
      countryAr: countryAr ?? this.countryAr,
      cityEn: cityEn ?? this.cityEn,
      cityAr: cityAr ?? this.cityAr,
      address: address ?? this.address,
      teachMethodInternet: teachMethodInternet ?? this.teachMethodInternet,
      teachMethodStudentHouse: teachMethodStudentHouse ?? this.teachMethodStudentHouse,
      teachMethodTeacherHouse: teachMethodTeacherHouse ?? this.teachMethodTeacherHouse,
      hasBioVideo: hasBioVideo ?? this.hasBioVideo,
      teachMethodOfflineByRoot: teachMethodOfflineByRoot ?? this.teachMethodOfflineByRoot,
      average: average ?? this.average,
      countryCode: countryCode ?? this.countryCode,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      distance: distance ?? this.distance,
      teacherSpecialityEntity: teacherSpecialityEntity ?? this.teacherSpecialityEntity,
    );
  }
}
