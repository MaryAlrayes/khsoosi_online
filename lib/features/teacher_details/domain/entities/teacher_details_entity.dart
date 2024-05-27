// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_category_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_certificates_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_courses_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_portofolio_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_review_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_services_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_universities_entity.dart';

class TeacherDetailsEntity extends Equatable {
  final String id;
  final String name;
  final String imagePath;

  //is Authenticated
  final bool isVipAccount;
  final bool isSpecial;

  //address
  final String residenseCountryEn;
  final String residenseCountryAr;
  final String residenseCityEn;
  final String residenseCityAr;
  final String residenseAddress;
  final String residenseCountryCode;

  //narionality
  final String nationalityAr;
  final String nationalityEn;
  final String nationalityCountryCode;

  final Gender gender;
  final int age;

  final bool elementary;
  final bool preparatory;
  final bool secondary;
  final bool university;

  final bool teachOnline;
  final bool teachPresence;

  final bool hasBioVideo;
  final String youtubeBio;
  final String lastDateActive;
  final bool isOnline;

  final double? averageRate;

  //about teacher
  final String teacherDescription;

  //categories
  final List<TeacherCategoryEntity> teacherSpecialityEntity;

  // reviews
  final List<TeacherDetailsReviewEntity> reviewEntity;

  //universites
  final List<TeacherUniversitiesEntity> universities;

  //certificates
  final List<TeacherCertificatesEntity> certificates;

  //courses
  final List<TeacherCoursesEntity> courses;

  //portofolios
  final List<TeacherPortofolioEntity> portofolio;

  //services
  final List<TeacherServicesEntity> services;
  TeacherDetailsEntity({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.isVipAccount,
    required this.isSpecial,
    required this.residenseCountryEn,
    required this.residenseCountryAr,
    required this.residenseCityEn,
    required this.residenseCityAr,
    required this.residenseAddress,
    required this.residenseCountryCode,
    required this.nationalityAr,
    required this.nationalityEn,
    required this.nationalityCountryCode,
    required this.gender,
    required this.age,
    required this.elementary,
    required this.preparatory,
    required this.secondary,
    required this.university,
    required this.teachOnline,
    required this.teachPresence,
    required this.hasBioVideo,
    required this.youtubeBio,
    required this.lastDateActive,
    required this.isOnline,
    required this.averageRate,
    required this.teacherDescription,
    required this.teacherSpecialityEntity,
    required this.reviewEntity,
    required this.universities,
    required this.certificates,
    required this.courses,
    required this.portofolio,
    required this.services,
  });

  @override
  List<Object?> get props => [

    id,
    name,
    imagePath,
    isVipAccount,
    isSpecial,
    residenseCountryEn,
    residenseCountryAr,
    residenseCityEn,
    residenseCityAr,
    residenseAddress,
    residenseCountryCode,
    nationalityAr,
    nationalityEn,
    nationalityCountryCode,
    gender,
    age,
    elementary,
    preparatory,
    secondary,
    university,
    teachOnline,
    teachPresence,
    hasBioVideo,
    youtubeBio,
    lastDateActive,
    isOnline,
    averageRate,
    teacherDescription,
    teacherSpecialityEntity,
    reviewEntity,
    universities,
    certificates,
    courses,
    portofolio,
    services,
  ];
}
