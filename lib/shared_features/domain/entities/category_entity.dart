// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name_ar;
  final String name_en;

  CategoryEntity({
    required this.id,
    required this.name_ar,
    required this.name_en,
  });

  @override
  List<Object?> get props => [
    id,
    name_ar,
    name_en,
  ];

  @override
  bool get stringify => true;
}
