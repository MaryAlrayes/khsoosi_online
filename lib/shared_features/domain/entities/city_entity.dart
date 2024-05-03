// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final String id;
  final String nameEn;
  final String nameAr;
  final String countryId;
  CityEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.countryId,
  });

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        countryId,
      ];
}
