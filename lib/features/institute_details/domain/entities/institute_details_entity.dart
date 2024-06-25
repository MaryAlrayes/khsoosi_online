// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:khosousi_online/features/institute_details/domain/entities/insitute_details_category_entity.dart';

import 'institute_details_course_entity.dart';

class InstituteDetailsEntity extends Equatable {
  final String id;
  final String name;
  final String job;
  final String email;
  final String image;
  final String description;
  final String mobile;
  final String mobileCountryCode;
  final String whatsapp;
  final String whatsappCountryCode;
  final String country;
  final String city;
  final String countryImageCode;
  final String address;
  final int coursesNumber;
  final int numberOfStages;
  final int eductaionalMethod;
  final List<InstituteDetailsCategoryEntity> categories;
  final List<InstituteDetailsCourseEntity> courses;
  InstituteDetailsEntity({
    required this.id,
    required this.name,
    required this.job,
    required this.email,
    required this.image,
    required this.description,
    required this.mobile,
    required this.mobileCountryCode,
    required this.whatsapp,
    required this.whatsappCountryCode,
    required this.country,
    required this.city,
    required this.countryImageCode,
    required this.address,
    required this.coursesNumber,
    required this.numberOfStages,
    required this.eductaionalMethod,
    required this.categories,
    required this.courses,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    job,
    email,
    image,
    description,
    mobile,
    mobileCountryCode,
    whatsapp,
    whatsappCountryCode,
    country,
    city,
    countryImageCode,
    address,
    coursesNumber,
    numberOfStages,
    eductaionalMethod,
    categories,
    courses,

  ];

  @override
  bool get stringify => true;


  }
