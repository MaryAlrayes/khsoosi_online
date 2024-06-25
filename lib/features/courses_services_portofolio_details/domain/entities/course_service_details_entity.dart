// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_details_category_entity.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_details_teacher_entity.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_rate_entity.dart';

class CourseServiceDetailsEntity extends Equatable {
  final String id;
  final String title;
  final bool isVip;
  final String image;
  final bool presense;
  final bool online;
  final String lastUpdate;
  final String summary;
  final String description;
  final String country;
  final String city;
  final String countryCode;
  final double? rate;

  final List<CourseServiceDetailsCategoryEntity> categories;
  final CourseServiceDetailsTeacherEntity teacher;
  final List<CourseServiceRateEntity> peopleRates;
  CourseServiceDetailsEntity({
    required this.id,
    required this.title,
    required this.isVip,
    required this.image,
    required this.presense,
    required this.online,
    required this.lastUpdate,
    required this.summary,
    required this.description,
    required this.country,
    required this.city,
    required this.countryCode,
    this.rate,
    required this.categories,
    required this.teacher,
    required this.peopleRates,
  });

  @override
  List<Object?> get props =>
      [
    id,
    title,
    isVip,
    image,
    presense,
    online,
    lastUpdate,
    summary,
    description,
    country,
    city,
    countryCode,
    rate,
    categories,
    teacher,
    peopleRates,];




 }
