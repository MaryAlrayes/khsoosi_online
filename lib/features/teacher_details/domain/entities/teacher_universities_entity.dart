// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class TeacherUniversitiesEntity extends Equatable {
 final String id;
 final String universityNameAr;
 final String universityNameEn;
 final String countryAr;
  TeacherUniversitiesEntity({
    required this.id,
    required this.universityNameAr,
    required this.universityNameEn,
    required this.countryAr,
  });

  @override

  List<Object?> get props => [
    id,
    universityNameAr,
    universityNameEn,
    countryAr,
  ];



}
