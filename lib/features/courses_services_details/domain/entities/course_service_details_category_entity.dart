// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CourseServiceDetailsCategoryEntity extends Equatable {
   final String id;
  final String nameAr;
  final String nameEn;
  CourseServiceDetailsCategoryEntity({
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
