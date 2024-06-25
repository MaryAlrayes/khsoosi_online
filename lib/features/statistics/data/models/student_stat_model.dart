// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:khosousi_online/features/statistics/data/models/requests_series_data_model.dart';
import 'package:khosousi_online/features/statistics/domain/entities/student_stat_entity.dart';

class StudentStatModel extends StudentStatEntity {

   StudentStatModel({

    required super.currentMonthRequestCount,
    required super.lastYearRequestCount,
    required super.data,
  });


  factory StudentStatModel.fromJson(Map<String, dynamic> map) {
    List<int> values = (map['requests_array'] as List<dynamic>)
        .map(
          (e) => e as int,
        )
        .toList();
    List<String> months = (map['date_array'] as List<dynamic>)
        .map(
          (e) => e as String,
        )
        .toList();
    return StudentStatModel(
      currentMonthRequestCount: map['current_month_contact_request_count'] ?? 0,
      lastYearRequestCount: map['last_12month_contact_request_count'] ?? 0,
      data: List.generate(
        values.length,
        (index) => RequestsSeriesDataModel.fromJson(
          month: months[index],
          value: values[index],
        ),
      ).toList(),
    );
  }
}
