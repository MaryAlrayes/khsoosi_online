// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:khosousi_online/features/statistics/domain/entities/requests_series_data_entity.dart';

class TeacherStatEntity extends Equatable {
  final int coursesCount;
  final int servicesCount;
  final int reviewsCount;
  final int portofolioCount;
  final int currentMonthRequestCount;
  final int lastYearRequestCount;
  final List<RequestsSeriesDataEntity> data;
  TeacherStatEntity({
    required this.coursesCount,
    required this.servicesCount,
    required this.reviewsCount,
    required this.portofolioCount,
    required this.currentMonthRequestCount,
    required this.lastYearRequestCount,
    required this.data,
  });

  @override
  List<Object?> get props => [
    coursesCount,
    servicesCount,
    reviewsCount,
    portofolioCount,
    currentMonthRequestCount,
    lastYearRequestCount,
    data,
  ];


}
