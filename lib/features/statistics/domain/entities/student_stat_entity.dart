// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:khosousi_online/features/statistics/domain/entities/requests_series_data_entity.dart';

class StudentStatEntity extends Equatable {

  final int currentMonthRequestCount;
  final int lastYearRequestCount;
  final List<RequestsSeriesDataEntity> data;
  StudentStatEntity({

    required this.currentMonthRequestCount,
    required this.lastYearRequestCount,
    required this.data,
  });

  @override
  List<Object?> get props => [
   
    currentMonthRequestCount,
    lastYearRequestCount,
    data,
  ];


}
