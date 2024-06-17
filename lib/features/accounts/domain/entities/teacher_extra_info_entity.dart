// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/features/location/domain/entities/city_entity.dart';

import '../../../location/domain/entities/country_entity.dart';

class TeacherExtraInfoEntity extends Equatable {
  final bool? teacheOnline;
  final bool? teachHouse;
  final bool? teachElementry;
  final bool? teachPreparatory;
  final bool? teachSecondary;
  final bool? teachUniversity;
  final String? address;
  final String certificates;
  final String skills;
  final List<CategoryEntity> categories;

  TeacherExtraInfoEntity({
    this.teacheOnline,
    this.teachHouse,
    this.teachElementry,
    this.teachPreparatory,
    this.teachSecondary,
    this.teachUniversity,
    this.address,
    required this.certificates,
    required this.skills,
    required this.categories,
  });

  factory TeacherExtraInfoEntity.empty() {
    return TeacherExtraInfoEntity(
      certificates: '',
      skills: '',
      categories: [],
    );
  }
  @override
  List<Object?> get props => [
        teacheOnline,
        teachHouse,
        teachElementry,
        teachPreparatory,
        teachSecondary,
        teachUniversity,
        address,
        certificates,
        skills,
        categories,
      ];

  TeacherExtraInfoEntity copyWith({
    bool? teacheOnline,
    bool? teachHouse,
    bool? teachElementry,
    bool? teachPreparatory,
    bool? teachSecondary,
    bool? teachUniversity,
    String? address,
    String? certificates,
    String? skills,
    List<CategoryEntity>? categories,
  }) {
    return TeacherExtraInfoEntity(
      teacheOnline: teacheOnline ?? this.teacheOnline,
      teachHouse: teachHouse ?? this.teachHouse,
      teachElementry: teachElementry ?? this.teachElementry,
      teachPreparatory: teachPreparatory ?? this.teachPreparatory,
      teachSecondary: teachSecondary ?? this.teachSecondary,
      teachUniversity: teachUniversity ?? this.teachUniversity,
      address: address ?? this.address,
      certificates: certificates ?? this.certificates,
      skills: skills ?? this.skills,
      categories: categories ?? this.categories,
    );
  }

  }
