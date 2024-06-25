// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums/enums.dart';

class ArticleEntity extends Equatable {
  final String id;
  final FAQUserType type;
  final String title;
  final String details;
  ArticleEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.details,
  });
@override
  List<Object?> get props => [
    id,
    type,
    title,
    details,
  ];




 }
